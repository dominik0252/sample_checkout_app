class CreditCard < ApplicationRecord
  belongs_to :customer

  validates :number, presence:true
  validates :valid_until_month, presence:true
  validates :valid_until_year, presence:true
  validate :valid_until_month_must_be_between_1_and_12
  validate :expiration_date_must_be_in_the_future

  def valid_until_month_must_be_between_1_and_12
    if self.valid_until_month.to_i < 1 || self.valid_until_month.to_i > 12
      errors.add(:valid_until_month, "must be valid month")
    end
  end

  def expiration_date_must_be_in_the_future
    begin
      expiration_date = DateTime.new(self.valid_until_year,self.valid_until_month,1) + 1.month - 1.day
      if expiration_date < Date.today
        errors.add(:base, "Expiration date cannot be in the past")
      end
    rescue
      errors.add(:base, "Invalid expiration date")
    end
  end
end
