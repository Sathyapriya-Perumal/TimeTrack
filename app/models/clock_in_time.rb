class ClockInTime < ApplicationRecord
  belongs_to :user

  #check if the particular clock in is late
  def late
    standard = Time.now.change(hour: 10)
    if self.time.localtime >= standard
      true
    end
  end

  def self.late_comers
    late_comers = self.all.select{|c| c.time.localtime >= Time.now.change(hour: 10)}.collect(&:user_id)
    temp = Hash.new {0}
    late_comers.each {|v| temp[v] += 1}
    return temp.select {|x, y| y >= 5}.keys
  end

  def self.late_comers_today
    self.all.select{|c| c.time.localtime >= Time.now.change(hour: 10) && c.time.localtime.to_date == Date.today }
  end

  def self.average_clockin_time
    temp = 0
    self.all.each{|c| temp += c.time.localtime.strftime("%H").to_i}
    temp / self.all.count if self.all.count != 0
  end
end
