# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ApplicationRecord
  has_many :user_categories
  has_many :users, through: :user_categories
  has_many :posts
end
