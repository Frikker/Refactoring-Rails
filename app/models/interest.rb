# frozen_string_literal: true

class Interest < ApplicationRecord
  has_many :user_interests
  has_many :user, through: :user_interests

  validates :name, presence: true, uniqueness: true
end