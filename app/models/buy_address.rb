class BuyAddress
  include ActiveModel::Model

  attr_accessor :token, :post_code, :prefecture_id, :municipality, :house_number, :building_name, :phone_number, :user_id,
                :item_id

  with_options presence: true do
    validates :token
    validates :post_code, format: { with: /\A\d{3}-\d{4}\z/ }
    validates :municipality
    validates :house_number
    validates :phone_number, format: { with: /\A[0-9]{10,11}\z/ }
    validates :user_id
    validates :item_id
  end
  validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' }

  def save
    buy = Buy.create(user_id: user_id, item_id: item_id)
    Address.create(post_code: post_code, prefecture_id: prefecture_id, municipality: municipality, house_number: house_number,
                   building_name: building_name, phone_number: phone_number, buy_id: buy.id)
  end
end
