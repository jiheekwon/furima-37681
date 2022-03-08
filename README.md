## Users テーブル

| Column             | Type   | Options                   |
| -------------------|--------|---------------------------|
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name_kana    | string | null: false               |
| birth              | date   | null: false               |


### Association
- has_many :items
- has_many :buys




## Items テーブル

| Column          | Type       | Options                        |
| ----------------|------------|--------------------------------|
| name            | string     | null: false                    |
| explain         | text       | null: false                    |
| category_id     | integer    | null: false                    |
| condition_id    | integer    | null: false                    |
| burden_id       | integer    | null: false                    |
| prefecture_id   | integer    | null: false                    |
| days_id         | integer    | null: false                    |
| price           | integer    | null: false                    |
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
| prefecture_id | integer    | null: false                    |
| municipality  | string     | null: false                    |
| house_number  | string     | null: false                    |
| building_name | string     |                                |
| phone_number  | string     | null: false                    |
| buy           | references | null: false, foreign_key: true |


### Association
- belongs_to :buy