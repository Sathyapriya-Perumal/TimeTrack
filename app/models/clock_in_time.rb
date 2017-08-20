class ClockInTime < ApplicationRecord
  belongs_to :user

  #check if the particular clock in is late
  def late
    standard = Time.now.change(hour: 10)
    if self.time.localtime >= standard
      true
    end
  end
end
