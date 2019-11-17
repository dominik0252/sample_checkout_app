include CustomersHelper

class Order < ApplicationRecord
  belongs_to :basket
  has_many :order_items

  before_save { self.customer_email.downcase! }

  validates :total_amount,    presence: true,
                              numericality: { greater_than_or_equal_to: 0 }
  validates :customer_name,   presence: true
  validates :customer_email,  presence: true,
                              format: { with: valid_email_regex }
  validates :customer_street, presence:true
  validates :customer_house_number, presence:true
  validates :customer_city, presence:true
  validates :customer_zip_code, presence:true
  validates :customer_country, presence:true
  validates :credit_card_number, presence:true
  validates :credit_card_valid_until_month, presence:true
  validates :credit_card_valid_until_year, presence:true

  def customer_address
    self.customer_street + " " + self.customer_house_number + ", " +
    self.customer_zip_code + " " + self.customer_city + ", " +
    self.customer_country
  end
end
