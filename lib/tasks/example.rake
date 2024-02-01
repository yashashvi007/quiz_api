require 'csv'

namespace :reports do 
  desc "Generate user signups resport for the past month"
  task :user_signups => :environment do 
    start_date = Time.current.beginning_of_month
    end_date = Time.current.end_of_month

    signups = User.where(created_at: start_date..end_date)
    p signups
  end 
end 