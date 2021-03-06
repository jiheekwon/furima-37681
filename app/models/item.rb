class Item < ApplicationRecord
  validates :name, presence: true
  validates :explain, presence: true
  validates :category_id, presence: true, numericality: { other_than: 1, message: 'を選択してください' }
  validates :condition_id, presence: true, numericality: { other_than: 1, message: 'を選択してください' }
  validates :burden_id, presence: true, numericality: { other_than: 1, message: 'を選択してください' }
  validates :prefecture_id, presence: true, numericality: { other_than: 1, message: 'を選択してください' }
  validates :shipping_date_id, presence: true, numericality: { other_than: 1, message: 'を選択してください' }
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }

  belongs_to :user
  has_one :buy

  has_one_attached :image
  validate :image_presence
  def image_presence
    errors.add(:image, 'を選択してください') unless image.attached?
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :burden
  belongs_to :prefecture
  belongs_to :shipping_date
end
