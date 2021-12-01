class Category < ApplicationRecord
    # adding validation to our category model
    validates :name,presence: true,uniqueness: {case_sensitive: false},length: {minimum: 10,maximum: 20}
end