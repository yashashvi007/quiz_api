class ApiController < ApplicationController
  before_action :authenticate_user! 
  include ErrorHandling
end