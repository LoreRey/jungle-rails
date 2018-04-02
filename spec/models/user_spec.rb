require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    it "must be created with matching password and password confirmation" do
      @user = User.create(first_name: 'Lorena', last_name: 'Reyes', email: 'lorena@gmail.com', password: 'test', password_confirmation: 'test')
      expect(User.find(@user.id)).not_to be_nil
    end

    it "must not be created with unmatching password and password confirmation" do
      @user = User.create(first_name: 'Lorena', last_name: 'Reyes', email: 'lorena@gmail.com', password: 'test', password_confirmation: 'trst')
      expect(@user.errors.full_messages()).to eq ["Password confirmation doesn't match Password"]
    end

    it "must be created with password and password confirmation" do
      @user = User.create(first_name: 'Lorena', last_name: 'Reyes', email: 'lorena@gmail.com', password: nil, password_confirmation: nil)
      expect(@user.errors.full_messages()).to eq ["Password can't be blank"]
    end

    it "must be created with unique email" do
      @user1 = User.create(first_name: 'Lorena', last_name: 'Reyes', email: 'lorena@gmail.com', password: 'test', password_confirmation: 'test')
      @user2 = User.create(first_name: 'Lorena', last_name: 'Rey', email: 'lorena@gmail.com', password: 'test2', password_confirmation: 'test2')
      expect(@user2.errors.full_messages()).to eq ["Email has already been taken"]
    end

    it "must be created with a first name" do
      @user = User.create(first_name: nil, last_name: 'Reyes', email: 'lorena@gmail.com', password: 'test', password_confirmation: 'test')
      expect(@user.errors.full_messages()).to eq ["First name can't be blank"]
    end


    it "must be created with a last name" do
      @user = User.create(first_name: 'Lorena', last_name: nil, email: 'lorena@gmail.com', password: 'test', password_confirmation: 'test')
      expect(@user.errors.full_messages()).to eq ["Last name can't be blank"]
    end


    it "must be created with an email" do
      @user = User.create(first_name: 'Lorena', last_name: 'Reyes', email: nil, password: 'test', password_confirmation: 'test')
      expect(@user.errors.full_messages()).to eq ["Email can't be blank"]
    end

  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
  end

end