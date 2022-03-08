## Users テーブル

| Column             | Type   | Options                   |
| -------------------|--------|---------------------------|
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| full_name          | string | null: false               |
| full_name_kana     | string | null: false               |
| birth              | string | null: false               |


### Association
- has_many :items
- has_many :buys




## Items テーブル

| Column          | Type       | Options                        |
| ----------------|------------|--------------------------------|
| name            | string     | null: false                    |
| explain         | text       | null: false                    |
| category        | string     | null: false                    |
| condition       | string     | null: false                    |
| shipping_fee    | string     | null: false                    |
| shipping_source | string     | null: false                    |
| shipping_days   | string     | null: false                    |
| price           | string     | null: false                    |
| user            | references | null: false, foreign_key: true |


### Association
- belongs_to :user
- has_one :buy




## Buys テーブル

| Column | Type       | Options                        |
| -------|------------|--------------------------------|
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |


### Association
- belongs_to :user
- belongs_to :item
- has_one :address




## Addresses テーブル

| Column        | Type       | Options                        |
| --------------|------------|--------------------------------|
| post_code     | string     | null: false                    |
| prefecture    | string     | null: false                    |
| municipality  | string     | null: false                    |
| house_number  | string     | null: false                    |
| building_name | string     |                                |
| phone_number  | string     | null: false                    |
| buy           | references | null: false, foreign_key: true |


### Association
- belongs_to :buy