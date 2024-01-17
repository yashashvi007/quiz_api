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
  
      if user_assesment.attended  
        x[:completed_assesment] << user_assesment  
      else
        x[:incomplete_assesment] << user_assesment  
      end
    end

    render json: {
      completed_assesment: x[:completed_assesment], 
      incomplete_assesment: x[:incomplete_assesment]
    }
  end
end  