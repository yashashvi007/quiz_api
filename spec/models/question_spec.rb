require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'validation' do 
    let(:assesment) {build(:assesment)}
    let(:question) { build(:question , assesment: assesment) }

    it 'test it' do 
      
    end 
  end 
end
