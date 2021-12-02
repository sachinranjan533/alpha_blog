require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = Category.create(name: "Sports")
    @admin_user=User.create(username: "admin",email: "admin@gmail.com",password: "password",admin: true) # creating a admin user
  end

  test "should get index" do
    get categories_url
    assert_response :success
  end

  test "should get new" do
    sign_in_as(@admin_user) #if sign in as admin user then perform below action
    get new_category_url
    assert_response :success
  end

  test "should create category" do
    sign_in_as(@admin_user) #if sign in as admin user then perform below action
    assert_difference('Category.count',1) do # 1 bcuz category count differ by 1 when we create new category.
      post categories_url, params: { category: {name: "Travel" } } # creating a category with name "Travel".
    end

    assert_redirected_to category_url(Category.last)
  end

  test "should not create category if not admin" do
    assert_no_difference('Category.count') do # 0 bcuz category count differ by 0 when we not create new category.
      post categories_url, params: { category: {name: "Travel" } } # creating a category with name "Travel".
    end

    assert_redirected_to categories_url
  end

  test "should show category" do
    get category_url(@category)
    assert_response :success
  end

  # test "should get edit" do
  #   get edit_category_url(@category)
  #   assert_response :success
  # end

  # test "should update category" do
  #   patch category_url(@category), params: { category: {  } }
  #   assert_redirected_to category_url(@category)
  # end

  # test "should destroy category" do
  #   assert_difference('Category.count', -1) do
  #     delete category_url(@category)
  #   end

  #   assert_redirected_to categories_url
  # end
end