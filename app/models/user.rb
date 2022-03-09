class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ } do
    validates :last_name,       presence: true
    validates :first_name,      presence: true
  end

  with_options presence: true, format: { with: /\A[ァ-ヴー]+\z/u } do
    validates :last_name_kana,  presence: true
    validates :first_name_kana, presence: true
  end

  validates :birth, presence: true
end
