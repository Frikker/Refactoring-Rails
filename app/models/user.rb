# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_interests
  has_many :interests, through: :user_interests
  has_many :user_skills
  has_many :skills, through: :user_skills

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
end
