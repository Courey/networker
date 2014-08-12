class Contact < ActiveRecord::Base
  belongs_to :company

  validates_format_of :first_name, with: /[a-zA-Z]/, message: "must include letters"
  validates_length_of :first_name, maximum: 30, message: "must be less than 30 characters"
  validates_presence_of :first_name

  validates_format_of :last_name, with: /[a-zA-Z]/, message: "must include letters"
  validates_length_of :last_name, maximum: 30, message: "must be less than 30 characters"
  validates_presence_of :last_name

  validates_format_of :title, with: /[a-zA-Z]/, message: "must include letters", on: :update, allow_nil: true
  validates_length_of :title, maximum: 30, message: "must be less than 30 characters", on: :update, allow_nil: true

  validates_format_of :email, with: /[a-zA-Z]/, message: "must include letters", on: :update, allow_nil: true
  validates_length_of :email, maximum: 30, message: "must be less than 30 characters", on: :update, allow_nil: true
  validates_uniqueness_of :email, message: "already exists", on: :update, allow_nil: true

  validates_format_of :phone, with: /[0-9]/, message: "must be numbers", on: :update, allow_nil: true
  validates_length_of :phone, maximum: 30, message: "must be less than 30 characters", on: :update, allow_nil: true
  validates_uniqueness_of :phone, message: "already exists", on: :update, allow_nil: true

  validates_format_of :description, with: /[a-zA-Z]/, message: "must include letters", on: :update, allow_nil: true
  validates_length_of :description, maximum: 130, message: "must be less than 130 characters", on: :update, allow_nil: true
end
