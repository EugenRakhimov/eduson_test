require 'rails_helper'

 RSpec.describe Exponat, type: :model do
  
  let(:exponat) { FactoryGirl.create :exponat }
  
  it "has a valid factory" do 
    expect(exponat.valid?).to be true
  end


  it "is invalid without link" do
    exponat.link = ''
    expect(exponat.valid?).to be false
  end
  it "is invalid if link is not a valid http link" do
    exponat.link = 'test.link'
    expect(exponat.valid?).to be false
  end

 end
