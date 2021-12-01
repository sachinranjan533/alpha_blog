require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  test "get new category form and create category" do
    get "/categories/new" # getting the url
    assert_response :success # if get the url then it is success
    assert_difference "Category.count",1 do # if difference between count is 1 then do
      post categories_path ,params: { category: {name: "Sports"} } # post the form.
      assert_response :redirect # if form submitted then redirect
    end
    follow_redirect! # follow the redirect
    assert_response :success # once you are following the redirect make sure that you are successfully able to do that.
    assert_match "Sports", response.body # matching the string "Sports" in the body.
  end
end