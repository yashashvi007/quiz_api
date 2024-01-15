class RemainderJob
  include Sidekiq::Job
  
  queue_as :high_priority

  def perform(*args)
    welcome_email(current_user)
  end
end
