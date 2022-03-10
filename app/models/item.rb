class Item < ApplicationRecord
  validates :name, presence: true
  validates :explain, presence: true
  validates :category_id, presence: true, numericality: { other_than: 1 }
  validates :condition_id, presence: true, numericality: { other_than: 1 }
  validates :burden_id, presence: true, numericality: { other_than: 1 }
  validates :prefecture_id, presence: true, numericality: { other_than: 1 }
  validates :shipping_date_id, presence: true, numericality: { other_than: 1 }
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }

  belongs_to :user

  has_one_attached :image
  validate :image_presence
  def image_presence
    unless image.attached?
      errors.add(:image, "can't be blank")
    end
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :burden
  belongs_to :prefecture
  belongs_to :shipping_date
end
