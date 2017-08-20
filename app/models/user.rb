class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  #add login accessor for email/username
  attr_accessor :login
  #validation for user name
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  #relation with clockins
  has_many :clock_in_times

  #for letting db know of login email/username

  def self.find_first_by_auth_conditions(warden_conditions)
  conditions = warden_conditions.dup
  if login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  else
    if conditions[:username].nil?
      where(conditions).first
    else
      where(username: conditions[:username]).first
    end
  end
end

  #check if user is clocked in before
  def clocked_in
    if clock_in_times.select {|c| c.time.localtime.to_date == Date.today}.count >= 1
      true
    end
  end
end
