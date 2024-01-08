class Users::DashboardController < ApiController 
  def index 
    user_assesments = UserAssesment.where(user_id: current_user.id)
    x = {}
    current_time = Time.current 
    end_time = Time.current + 1.day 

    x={}
    x[:user_assesment] = []
    x[:completed_assesment] = []
    x[:incomplete_assesment] = []

    user_assesments.each do |user_assesment| 

      debugger

      if user_assesment.assesment.scheduled_at < end_time 
        x[:user_assesment] << user_assesment
      end 

      if user_assesment.assesment.completed 
        x[:completed_assesment] << user_assesment
      else 
        x[:incomplete_assesment] << user_assesment 
      end
    end

    p x
  end
end  