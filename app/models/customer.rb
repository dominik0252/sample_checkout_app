include CustomersHelper

class Customer < ApplicationRecord
  has_many :credit_cards

  before_save { self.email.downcase! }

  validates :name, presence:true
  validates :email, presence:true,
                    format: { with: valid_email_regex },
                    uniqueness: { case_sensitive: false }
  validates :street, presence:true
  validates :house_number, presence:true
  validates :city, presence:true
  validates :zip_code, presence:true
  validates :country, presence:true
end
