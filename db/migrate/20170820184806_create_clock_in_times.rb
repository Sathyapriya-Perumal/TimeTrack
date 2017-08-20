class CreateClockInTimes < ActiveRecord::Migration[5.1]
  def change
    create_table :clock_in_times do |t|
      t.references :user
      t.datetime :time
      t.timestamps
    end
  end
end
