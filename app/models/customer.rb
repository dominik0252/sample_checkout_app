class Customer < ApplicationRecord
  has_many :credit_cards

  before_save { self.email.downcase! }
  validates :name, presence:true
  validates :email, presence:true
  validates :street, presence:true
  validates :house_number, presence:true
  validates :city, presence:true
  validates :zip_code, presence:true
  validates :country, presence:true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :credit_cards, presence:true
end
