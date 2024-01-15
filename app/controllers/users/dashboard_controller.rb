class Users::DashboardController < ApiController 
  def index 
    user_assesments = UserAssesment.where(user_id: current_user.id)
    x = {}
    current_time = Time.now 
    end_time = Time.now + 1.day 

    x={}  
    x[:user_assesment] = []  
    x[:completed_assesment] = [] 
    x[:incomplete_assesment] = []  

    user_assesments.each do |user_assesment|   
  
      if user_assesment.assesment.scheduled_at > current_time && user_assesment.assesment.scheduled_at < end_time 
        x[:user_assesment] << user_assesment 
      end  

      if user_assesment.attended  
        x[:completed_assesment] << user_assesment  
      else
        x[:incomplete_assesment] << user_assesment  
      end
    end

    render json: {
      user_assesment: x[:user_assesment], 
      completed_assesment: x[:completed_assesment], 
      incomplete_assesment: x[:incomplete_assesment]
    }
  end
end  