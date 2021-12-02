require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest

  setup do
    @admin_user=User.create(username: "admin",email: "admin@gmail.com",password: "password",admin: true) # creating a admin user
    sign_in_as(@admin_user) # both test require the sign in.
  end

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

  test "get new category form and reject invalid category" do
    get "/categories/new" # getting the url
    assert_response :success # if get the url then it is success
    assert_no_difference "Category.count" do # no difference in case of invalid category
      post categories_path ,params: { category: {name: " "} } # post the form.
    end
    assert_match "errors", response.body # matching the string "errors" in the body.
    assert_select "div.alert" # matching the class "alert" in div tag html body
    assert_select "h4.alert-heading" # matching the class "alert heading" in h4 tag in html body.
  end
end