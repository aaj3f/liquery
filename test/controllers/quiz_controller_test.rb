require 'test_helper'

class QuizControllerTest < ActionDispatch::IntegrationTest
  test "should get question_one" do
    get quiz_question_one_url
    assert_response :success
  end

  test "should get answer_one" do
    get quiz_answer_one_url
    assert_response :success
  end

  test "should get question_two" do
    get quiz_question_two_url
    assert_response :success
  end

  test "should get answer_two" do
    get quiz_answer_two_url
    assert_response :success
  end

  test "should get question_three" do
    get quiz_question_three_url
    assert_response :success
  end

  test "should get answer_three" do
    get quiz_answer_three_url
    assert_response :success
  end

end
