# frozen_string_literal: true

class Ability
  include CanCan::Ability

  # def initialize(user)
  #   if user.super_admin? 
  #     can :manage, :all
  #   else user.admin?  
  #     # can :read, Company, user_id: user.id 
  #     # can :update, Company, user_id: user.id 
  #     can :manage , Assesment
  #     can :manage, UserAssesment
  #   # else 
  #   #   can :read, Assesment
  #   end
  # end
end
