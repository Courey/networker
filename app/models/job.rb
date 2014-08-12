class Job < ActiveRecord::Base
  belongs_to :company

  validates_format_of :name, with: /[a-zA-Z]/, message: "must include letters"
  validates_length_of :name, maximum: 30, message: "must be less than 30 characters"
  validates_presence_of :name

  validates_format_of :description, with: /[a-zA-Z]/, message: "must include letters", on: :update, allow_nil: true
  validates_length_of :description, maximum: 130, message: "must be less than 130 characters", on: :update, allow_nil: true
  validates_presence_of :description, on: :update, allow_nil: true

  validates_format_of :requirements, with: /[a-zA-Z]/, message: "must include letters", on: :update, allow_nil: true
  validates_length_of :requirements, maximum: 130, message: "must be less than 130 characters", on: :update, allow_nil: true
  validates_presence_of :requirements, on: :update, allow_nil: true
end
