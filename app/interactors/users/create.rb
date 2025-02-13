# frozen_string_literal: true

module Users
  class Create < ActiveInteraction::Base
    string :name, :surname, :email, :patronymic, :gender, :nationality, :country
    integer :age
    array :interests
    array :skills

    validates :name, :patronymic, :surname, :nationality, :country, presence: true
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :age, presence: true, numericality: { greater_than: 0, less_than: 90 }
    validates :gender, inclusion: { in: %w[male female] }, presence: true

    validate :check_email_uniqueness

    def execute
      user = User.create(inputs.except(:skills, :interests).merge(full_name: user_full_name))

      set_interests(user)
      set_skills(user)
    end

    private

    def user_full_name
      [ surname, name, patronymic ].join(" ")
    end

    def set_interests(user)
      return if interests.empty?
      user.interests = Interest.where(name: interests)
    end

    def set_skills(user)
      return if skills.empty?
      user.skills = Skill.where(name: interests)
    end

    def check_email_uniqueness
      return unless User.exists?(email: email)

      errors.add(:email, "has already been taken")
    end
  end
end