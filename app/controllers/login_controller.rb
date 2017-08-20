class LoginController < ApplicationController
  def index
      if current_user
      unless current_user.admin?
        clockins = current_user.clock_in_times.sort_by {|c| c.time} if current_user
        @clockins = Kaminari.paginate_array(clockins).page(params[:page]).per(10)
      else
        clockins = ClockInTime.late_comers_today.sort_by {|c| c.time}
        @clockins = Kaminari.paginate_array(clockins).page(params[:page]).per(10)
        late_clockins =ClockInTime.late_comers
        @users = User.where(id: late_clockins)
      end
    end
  end

  def clockin_ledger
    clockins = ClockInTime.select{|c| c.time.localtime.to_date == Date.today}.sort_by {|c| c.time}
    @clockins = Kaminari.paginate_array(clockins).page(params[:page]).per(10)

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

  def user_ledger
    @user = User.where(id: params[:user]).first
    clockins = @user.clock_in_times.sort_by {|c| c.time}
    @clockins = Kaminari.paginate_array(clockins).page(params[:page]).per(10)
    @user_ledger = true
  end

  def destroy_user
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end
end
