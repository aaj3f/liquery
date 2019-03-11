require 'rails_helper'

RSpec.describe User, type: :model do
  context 'registering new users' do
    before(:each) do
      @valid_attributes = {
        email: "testemail@test.com",
        password: "testpassword"
      }
    end

    it 'is invalid without an email address' do
      @invalid_attrbiutes = @valid_attributes.merge(email: "")

      expect(User.new(@invalid_attrbiutes).valid?).to eq(false)
    end

    it 'is invalid without a password' do
      @invalid_attrbiutes = @valid_attributes.merge(password: "")

      expect(User.new(@invalid_attrbiutes).valid?).to eq(false)
    end

    it 'is invalid without a properly formatted email address' do
      @invalid_attrbiutes = @valid_attributes.merge(email: "test")

      expect(User.new(@invalid_attrbiutes).valid?).to eq(false)
    end

    it 'is invalid with a password shorter than six characters' do
      @invalid_attrbiutes = @valid_attributes.merge(password: "test1")

      expect(User.new(@invalid_attrbiutes).valid?).to eq(false)
    end

    it 'is valid with a proper email and password' do
      expect(User.new(@valid_attributes).valid?).to eq(true)
    end

    it 'is invalid with an already used email address' do
      User.create(@valid_attributes)

      expect(User.new(@valid_attrbiutes).valid?).to eq(false)
    end




  end
end
