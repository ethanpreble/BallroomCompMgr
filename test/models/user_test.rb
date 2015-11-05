require '../test_helper'

class UserTest < ActiveSupport::TestCase
  test "fields cannot be null" do
    user = User.new
    assert_not user.valid?
    assert_equal ["can't be blank"], user.errors[:first_name]
    assert_equal ["can't be blank"], user.errors[:last_name]
    assert_equal ["can't be blank"], user.errors[:email]
    assert_equal ["can't be blank"], user.errors[:password]
  end
  
  test "email must have @ symbol" do
    user = User.new(email: 'invalid_email')
    assert_not user.valid?
    assert_equal ["is invalid"], user.errors[:email]
  end
  
  test "valid user" do
    user = User.new(first_name: 'john', last_name: 'doe', email: 'john_doe@fake.com', password: 'a_password')
    assert user.valid?
    assert user.save
  end
  
  test "email must be unique" do
    assert User.create(first_name: 'john', last_name: 'doe', email: 'john_doe@fake.com', password: 'a_password').valid?
    assert_equal 1, User.count
    user = User.new(first_name: 'john', last_name: 'doe', email: 'john_doe@fake.com', password: 'a_password')
    assert user.invalid?
    assert_equal ["has already been taken"], user.errors[:email]
  end
  
end
