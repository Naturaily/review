require 'spec_helper'

describe Commit do

  it { should respond_to(:project) }
  it { should respond_to(:project_id) }

  let(:remote_id) { '19a8f144c94f0a7c38e7bd4fe0b018e8dca4c349' }
  let(:fixing_remote_id) { '19a8f144c94f0a7c38e7bd4fe0b018e8dca4c350' }
  let(:commit_author) { GithubHookParser::Person.new(name: 'levis', email: 'john@levis.com', username: 'john levis') }

  let(:commit_attributes) do
    {
      'url' => 'http://test.host/netguru/review/commit/123123',
      'message' => 'cool commit message',
      'remote_id' => remote_id,
    }
  end

  let(:fixing_attributes) do
    {
      'url' => 'http://test.host/netguru/review/commit/123123',
      'message' => "fixing [#{commit.remote_id}]",
      'remote_id' => fixing_remote_id,
    }
  end

  let(:remote_commit) do
    double('RemoteCommit', remote_id: remote_id, attributes: commit_attributes, tickets: [], author: commit_author)
  end

  describe "#get_associated_project" do

    let(:commit_creation){ -> { described_class.create(commit_attributes) } }

    it "creates new project for new commit" do
      expect(commit_creation).to change{ Project.count }
    end

    it "doesnt create project duplicates" do
      commit_creation.call
      expect(commit_creation).not_to change{ Project.count }
    end
  end

  describe 'commit creation' do
    it "adds new commit" do
      expect do
        described_class.add_remote(remote_commit)
      end.to change{ described_class.count }.by(1)
    end

    it "doesnt create new commit twice" do
      expect do
        2.times { described_class.add_remote(remote_commit) }
      end.to change{ described_class.count }.by(1)
    end
  end

  describe 'state machine' do
    let(:commit){ described_class.create(commit_attributes) }

    before do
      Timecop.freeze DateTime.new(2015, 6, 26, 15)
      commit
    end

    after { Timecop.return }

    it 'ensures initial state is `pending`' do
      expect(commit).to be_pending
    end

    it 'sets proper expiration date' do
      expect(commit.expires_at).to eq '2015-06-30 15:00:00'
    end

    [:reject, :pass, :accept, :fixed].permutation(2).to_a.each do |from, to|
      it "allows to change states between #{from} and #{to}" do
        expect do
          commit.public_send(from)
          commit.public_send(to)
        end.to be_true
      end
    end

    it 'disallows to change state to the same we are in' do
      [:reject, :pass, :accept].each do |action|
        expect(commit.public_send(action)).to be_true
        expect(commit.public_send(action)).to be_false
      end
    end

    it 'changes commit spec when proper message passed' do
      described_class.create(fixing_attributes)
      expect(commit.reload.state).to eq('fixed')
    end

    it 'sets expires_at when passing commit' do
      Timecop.freeze DateTime.new(2015, 6, 30, 14)
      commit.pass
      expect(commit.reload.expires_at).to eq '2015-07-02 14:00:00'
    end
  end

  describe 'commit fixation' do
    let!(:commit){ described_class.create(commit_attributes) }
    let!(:fixing_commit){ described_class.create(fixing_attributes) }

    it 'creates commit fix' do
      expect(CommitFix.count).to eq(1)
    end

    it 'can access its fixing commit' do
      expect(commit.fixes.first).to eq(fixing_commit)
    end

    it 'can access fixed commit' do
      expect(fixing_commit.fixed.first).to eq(commit)
    end
  end
end
