class Commit < ActiveRecord::Base

  before_create :get_associated_project
  belongs_to :project
  has_and_belongs_to_many :tickets

  scope :for_state, ->(state){ where(state: state) }

  scope :accepted, ->{ for_state 'accepted' }
  scope :pending, ->{ for_state 'pending' }
  scope :rejected, ->{ for_state 'rejected' }
  scope :passed, ->{ for_state 'passed' }

  state_machine :state, :initial => :pending do

    event :accept do
      transition all - :accepted => :accepted
    end

    event :pass do
      transition all - :passed => :passed
    end

    event :reject do
      transition all - :rejected => :rejected
    end
  end

  def self.add_remote(remote_commit)
    unless where(remote_id: remote_commit.remote_id).exists?
      create(remote_commit.attributes) do |commit|
        commit.add_remote_tickets remote_commit.tickets
      end
    end
  end

  def attempt_transition_to(state)
    self.state_event = external_transitions.fetch(state) { "undefined transition" }
  end

  def add_remote_tickets(tickets)
    tickets.each { |ticket| add_remote_ticket ticket }
  end

  def add_remote_ticket(remote_ticket)
    ticket = Ticket.where(remote_id: remote_ticket.ticket_id, source: remote_ticket.ticket_type).first
    ticket ||= Ticket.create remote_ticket.attributes
    self.tickets << ticket
  end

  def self.add_batch_remote(commits)
    commits.map{ |commit| add_remote commit }.compact
  end

  private

  def external_transitions
    {
      "accepted" => "accept",
      "passed" => "pass",
      "rejected" => "reject",
    }
  end

  def get_associated_project
    if url.present? and (parts = url.split('/'))[4].present?
      self.project = Project.find_or_create_by(name: parts[4])
    end
  end
end
