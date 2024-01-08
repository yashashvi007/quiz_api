require 'rails_helper'

RSpec.describe Assesment, type: :model do

  let(:assesment) {build(:assesment)}

  describe "association validation" do 
    it 'should validate' do 
      expect(assesment).to be_valid
    end
    context 'when title is empty' do 
      let(:assesment) {build(:assesment, title: nil)}
      it 'is not valid with title nil' do 
        expect(assesment).to_not be_valid
      end
    end


    context 'when title is empty' do 
      let(:assesment) {build(:assesment, duration: nil)}
      it 'should not be valid with duration nil' do 
        expect(assesment).to_not be_valid
      end 
    end

  end 
end 