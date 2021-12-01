require  'test_helper'

class CategoryTest <ActiveSupport::TestCase

    #this methods runs before every test
    def setup
        @category=Category.new(name: "sports")
    end

    test "category should be valid" do
        assert @category.valid? # ensure that test is true
    end

    # defining test which check whether name is present or not
    test "name should be present" do
        @category.name=" "
        assert_not @category.valid? #ensure that test is false
    end

    # defining test which check whether name is unique or not
    test "name should be unique" do
        @category.save #first we need to stor in test DB to check uniqueness.
        @category2=Category.new(name: "Sports")
        assert_not @category2.valid?
    end

    # defining test which check whether name is not too long
    test "name should not be too long" do
        @category.name="a"*26
        assert_not @category.valid?
    end

    # defining test which check whether name is not too short
    test "name should not be too short" do
        @category.name="a"
        assert_not @category.valid?
    end

end