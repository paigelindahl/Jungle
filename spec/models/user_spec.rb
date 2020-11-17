require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should save successfuly when fields are filled in' do
      @user = User.new
      @user.name = 'Paige'
      @user.email = 'paige@email.com'
      @user.password = 'password'
      @user.password_confirmation = 'password'

      expect(@user).to be_present
    end

    it 'should fail if name is left blank' do
      @user = User.new
      @user.name = nil
      @user.email = 'paige@email.com'
      @user.password = 'password'
      @user.password_confirmation = 'password'

      @user.save
      
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    it 'should fail when passwords do not match' do
      @user = User.new
      @user.name = 'Paige'
      @user.email = 'paige@email.com'
      @user.password = 'password'
      @user.password_confirmation = 'password1'

      @user.save

      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")

    end

    it 'should fail if email is left blank' do
      @user = User.new
      @user.name = 'Paige'
      @user.password = 'password'
      @user.password_confirmation = 'password'

      @user.save

      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    context 'email validations' do
      @user1 = User.new(name: 'Paige', email: 'paige@email.com', password: 'password', password_confirmation: 'password')

      @user1.save

      it 'validates email uniqueness' do
        @user2 = User.new(name: 'Kristen', email: 'paige@email.com', password: 'password', password_confirmation: 'password')

        @user2.save

        expect(@user2.errors.full_messages).to include("Email has already been taken")
      end

      it 'validates case sensitivity' do
        @user2 = User.new(name: 'Kristen', email: 'paige@email.COM', password: 'password', password_confirmation: 'password')

        @user2.save

        expect(@user2).to_not be_valid
      end
    end
    it 'should fail if password is less than three characters' do
      @user = User.new(name: 'Barry', email: 'barry@email.com', password: 'a', password_confirmation: 'a')

      @user.save

      expect(@user).to_not be_valid
    end

  end

  describe '.authentication_with_credentials' do
    it 'should return the user' do
      #with .create it saves for you (unlike .new)
      actual_user = User.create(name: 'Kourt', email: 'kourt@email.com', password: 'password', password_confirmation: 'password')
      new_user = User.authenticate_with_credentials('kourt@email.com', 'password')
      expect(new_user).to eq(actual_user)
    end

    it 'should return nil if not authenticated' do
      @user = User.new(name: 'Saad', email: 'saad@email.com', password: 'password', password_confirmation: 'password')
      @user.save
      @invalid_user = User.authenticate_with_credentials('saad@email.com', 'password1')
      expect(@invalid_user).to eq nil
    end

    it 'should authenticate if user adds uppercase letters to the email' do
      @user = User.new(name: 'Saad', email: 'saad@email.com', password: 'password', password_confirmation: 'password')
      @user.save
      @valid_user = User.authenticate_with_credentials('SAAD@email.com', 'password')
      expect(@valid_user).to eq(@user)
    end

    it 'should authenticate if user adds spaces to beginning or end of email' do
      user = User.new(name: 'b', email: 'email@email.com', password: 'apples', password_confirmation: 'apples')
      user.save
      valid_user = User.authenticate_with_credentials(' email@email.com ', 'apples')
      expect(valid_user).to eq(user)
    end
  end
end
