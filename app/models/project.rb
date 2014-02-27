class Project < ActiveRecord::Base
  has_many :commits
  has_many :permissions

  validates :name,  uniqueness: true
  validates :token, uniqueness: true

  before_create :generate_token!
  scope :from_token, ->(token){ where(token: token) }

  def self.create_from_hash remote_repository
    create(remote_repository.attributes).save
  end

private
  def generate_token!
    begin
      self.token = SecureRandom.hex
    end while self.class.from_token(self.token).exists?
  end
end
