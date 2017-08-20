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
  has_many :clock_in_times, dependent: :destroy

  #to send delted mail
  before_destroy :send_mail_to_user
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

  def send_mail_to_user
    UserMailer.deleted_email(self).deliver_now
  end

  def average_clockin_user
    temp = 0
    clock_in_times.each{|c| temp += c.time.localtime.strftime("%H").to_i}
    temp / clock_in_times.count if  clock_in_times.count != 0
  end
end
