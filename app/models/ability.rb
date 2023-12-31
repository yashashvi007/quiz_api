# frozen_string_literal: true

class Ability
  include CanCan::Ability
  
  def initialize(user)
    if user.super_admin? 
      can :manage, :all
    elsif user.admin?  
      # can :read, Company, user_id: user.id 
      # can :update, Company, user_id: user.id 
      can :create , Assesment 
      can :update , Assesment, user_id: user.id
      can :destroy , Assesment, user_id: user.id
      can :read , Assesment
      can :manage , UserAssesment 
      
    elsif user.student? 
      can :read, Assesment 
      can :read , UserAssesment , user_id: user.id
      can :create , Response 
    end
  end
end
