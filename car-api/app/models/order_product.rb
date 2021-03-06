class OrderProduct < ApplicationRecord
  before_validation  :set_product_total!
  after_create :decrement_product_quantity
  belongs_to :product
  validates_associated :product
  belongs_to :order

  validates :total, presence: true, numericality: { greater_or_equal_than: 0 }
  validates :quantity, presence: true,
                       numericality: { greater_than_or_equal_to: 1, less_than: 1001, only_integer: true }

  validate :total_is_the_product_between_price_and_quantity

  def total_is_the_product_between_price_and_quantity
    errors.add(:total, 'Total product cost need to be price * quantity') if total != product.price * quantity
  end

  def set_product_total!
    self.total = product.price * quantity
  end

  def decrement_product_quantity
    product.decrement!(:quantity, quantity) if product.quantity - quantity >= 0
  end
end
