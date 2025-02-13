# frozen_string_literal: true

class Skill < ApplicationRecord
  # 1-й способ
  self.table_name = "skils"
  # 2-й способ - создать миграцию на переименование таблицы
  has_many :user_skills
  has_many :user, through: :user_skills

  validates :name, presence: true, uniqueness: true
end