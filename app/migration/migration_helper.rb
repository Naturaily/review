module MigrationHelper
  def self.associate_commit_fixes
    CommitFix.where.not(fixed_mongo_id: nil).each do |commit_fix|
      fixing_commit_id = Commit.find_by_remote_id(commit_fix.fixes_mongo_id).id
      fixed_commit_id = Commit.find_by_remote_id(commit_fix.fixed_mongo_id).id
      commit_fix.update(fixing_commit_id: fixing_commit_id, fixed_commit_id: fixed_commit_id)
    end
  end
 
  def self.associate_commits
    Commit.where.not(author_email: nil, project_mongo_id: nil).each do |commit|
      author_id = Person.find_by_email(commit.author_email).id
      project = Project.where(mongo_id: commit.project_mongo_id).first
      if project
        url = "https://github.com/netguru/#{project.name}/commit/#{commit.remote_id}" #default url formation for github commit web page
        commit.update(author_id: author_id, project_id: project.id, url: url)
      end
    end
  end
  def self.associate_permissions
    Permission.where.not(mongo_id: nil).each do |permission|
      user_id = User.find_by_mongo_id(permission.user_mongo_id).id
      project = Project.where(mongo_id: permission.project_mongo_id).first
      permission.update(user_id: user_id, project_id: project.id) if project
    end
  end
  def self.associate_tokens
    Token.where.not(mongo_id: nil, tokenable_mongo_id: nil, tokenable_type: 'Server').each do |token| #ignore server tokens
      clazz = token.tokenable_type.constantize
      tokenable = clazz.where(mongo_id: token.tokenable_mongo_id).first
      token.update(tokenable_id: tokenable.id) if tokenable
    end
  end
  def self.associate_users
    User.where.not(mongo_id: nil).each do |user|
      person = Person.find_by_email user.email
      user.update(person_id: person.id) if person
    end
  end
  def self.set_default_project_trade_details
    Project.where(trade_details: nil).update_all(trade_details: Project.trade_details[:internal]) #use desired trade details
  end
  def self.set_default_permissions
    Permission.where(old_level: 'developer').update_all(allowed: true) #adjust levels to your needs
    Permission.where.not(old_level: 'developer').where.not(old_level: nil).update_all(allowed: false)
  end
end
