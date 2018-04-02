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
      expect(@user.errors.full_messages()).to include("Password can't be blank")
    end

    it "must not be created with a password with less than the minimum length" do
      @user = User.create(first_name: 'Lorena', last_name: 'Reyes', email: 'lorena@gmail.com', password: 'hey', password_confirmation: 'hey')
      expect(@user.errors.full_messages()).to include("Password is too short (minimum is 4 characters)", "Password confirmation is too short (minimum is 4 characters)")
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

    # before :each do
    # @user = new
    # @user.save

    # result = User.authenticate_with_credentials('lorena@gmail.com', 'test')
    # expect(@result.class).to eq @user

    it 'authenticates a user with correct credentials' do
      @user = User.create(first_name: 'lorena', last_name: 'Reyes', email: 'lorena@gmail.com', password: 'test', password_confirmation: 'test')
      expect(User.authenticate_with_credentials('lorena@gmail.com', 'test')).to eq @user
    end

    it 'not authenticates a user with incorrect credentials' do
      @user = User.create(first_name: 'Lorena', last_name: 'Reyes', email: 'lorena@gmail.com', password: 'test', password_confirmation: 'test')
      expect(User.authenticate_with_credentials('lorena@hotmail.com', 'trst')).to_not eq @user
    end

    it "authenticates user with whitespace before email" do
      @user = User.create(first_name: 'Lorena', last_name: 'Reyes', email: 'lorena@gmail.com', password: 'test', password_confirmation: 'test')
      expect(User.authenticate_with_credentials(' lorena@hotmail.com', 'test')).to_not eq @user
    end

    it "authenticates user with wrong case in email" do
      @user = User.create(first_name: 'Lorena', last_name: 'Reyes', email: 'lorena@gmail.com', password: 'test', password_confirmation: 'test')
      expect(User.authenticate_with_credentials('LorEnA@HOTMAIL.com', 'test')).to_not eq @user
    end

  end

end