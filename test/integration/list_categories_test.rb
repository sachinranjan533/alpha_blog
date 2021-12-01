require "test_helper"

class ListCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @category=Category.create(name: "Sports")
    @category2=Category.create(name: "Newspaper")
  end
  test "listing of categories" do
    get "/categories"
    assert_select "a[href=?]",category_path(@category),text: @category.name # match for a link that generated here and link will appear here in the form of name which is specified by text.
    assert_select "a[href=?]",category_path(@category2),text: @category2.name # match for a link that generated here and link will appear here in the form of name which is specified by text.
  end
end
