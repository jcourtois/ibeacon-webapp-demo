class Customer < ActiveRecord::Base
  after_initialize :standardize_membership_number
  validates :membership_number, presence: true

  has_many :visits

  private

  def standardize_membership_number
    membership_number.to_s.gsub!(/\D/, '')
  end

end
