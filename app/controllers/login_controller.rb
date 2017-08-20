class LoginController < ApplicationController
  def index
    @clockins = current_user.clock_in_times if current_user
  end
  def clockin
    unless current_user.clocked_in
      @clockin = current_user.clock_in_times.new
      @clockin.time = Time.now
      @clockin.save
      unless @clockin.late
        flash[:notice] = "Boom! You have clocked in for today."
      else
        flash[:notice] = "Hi! you are the past clock in, there it goes in red."
      end
    else
      flash[:alert] = "Oops! It seems you have already clocked in."
    end
  end
end
