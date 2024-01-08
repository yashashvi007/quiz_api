class RemainderJob
  include Sidekiq::Job
  
  # queue_as :default

  def perform
    
    p "hey how are you i am shanakr in remaider job "
    # begin
      # Existing code
      # user_assesments = UserAssesment.all 

      # user_assesments.each do |user_assesment| 
      #   user = user_assesment.user
      #   UserMailer.with(user: user).welcome_email.deliver_now
      # end
    # rescue StandardError => e
    #   Rails.logger.error("Error in RemainderJob: #{e.message}")
    #   raise e  # re-raise the exception so that Sidekiq can mark the job as failed
    # end
  end
end
