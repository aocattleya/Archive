# Mercari_clone DB設計

## users テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| nickname        | string     | null: false, unique: true      |
| email           | string     | null: false, unique: true      |
| password        | string     | null: false                    |
| last_name       | string     | null: false                    |
| first_name      | string     | null: false                    |
| last_name_kana  | string     | null: false                    |
| first_name_kana | string     | null: false                    |
| birthday        | string     | null: false                    |
| address_id      | references | null: false, foreign_key: true |
| profile         | text       |                                |
| image           | string     |                                |

### Association

- has_many : comments
- has_many : likes
- has_many : items
- has_many : ordercomments
- has_many : address
- has_many : users_transacts
- has_many : transacts through::users_transacts

## items テーブル

| Column          | Type       | Options                         |
| --------------- | ---------- | ------------------------------- |
| name            | string     | null: false, index: true        |
| price           | integer    | null: false, index: true        |
| size            | integer    | enum, index: true               |
| condition       | integer    | enum, null: false               |
| shipping_date   | integer    | enum, null: false               |
| shipping_price  | integer    | enum, null: false               |
| shipping_area   | integer    | enum, null: false               |
| shipping_method | integer    | enum, null: false               |
| category_id     | references | null: false,  foreign_key: true |
| brand_id        | references | null: false, foreign_key: true  |
| user_id         | references | null: false, foreign_key: true  |

### Association

- has_many : images
- has_many : comments
- has_many : likes
- has_many : orders
- belongs_to : user
- belongs_to : category
- belongs_to : brand

## addresses テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| postal_code     | integer    | null: false                    |
| prefecture      | string     | null: false                    |
| city            | string     | null: false                    |
| street          | string     | null: false                    |
| building        | string     |                                |
| phone           | string     | null: false                    |
| first_name      | string     | null: false                    |
| last_name       | string     | null: false                    |
| first_name_kana | string     | null: false                    |
| last_name_kana  | string     | null: false                    |
| user_id         | references | null: false, foreign_key: true |

### Association

- belongs_to : user

## users_transacts テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| user_id     | references | null: false, foreign_key: true |
| transact_id | references | null: false, foreign_key: true |

### Association

- belongs_to : user
- belongs_to : transact

## transacts テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| evaluate  | integer    | enum, null: false              |
| confirm   | boolean    | default: false                 |
| body      | text       |                                |
| seller_id | integer    |                                |
| buyer_id  | integer    |                                |
| item_id   | references | null: false, foreign_key: true |

### Association

- has_many : users_transacts
- belongs_to : user

## ordercomments テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| comment  | text       | null: false                    |
| user_id  | references | null: false, foreign_key: true |
| order_id | references | null: false, foreign_key: true |

### Association

- belongs_to user
- belongs_to order

## orders テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| state   | integer    | null: false, dafault: 0        |
| item_id | references | null: false, foreign_key: true |

### Association

- has_many : ordercomments
- belongs_to : item

## categories テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| name     | string     | null: false, index: true       |
| ancestry | integer    | index: true                    |
| item_id  | references | null: false, foreign_key: true |

### Association

- has_many : items
- has_many : brands_categories

## brands テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| name    | string     | null: false, index: true       |
| item_id | references | null: false, foreign_key: true |

### Association

- has many : items
- has many : categories through brands_categories

## brands_categories テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| brand_id    | references | null: false, foreign_key: true |
| category_id | references | null: false, foreign_key: true |

### Association

- belongs_to : brand
- belongs_to : category

## images テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| image   | string     | null: false                    |
| item_id | references | null: false, foreign_key: true |

### Association

- belongs_to : item

## comments テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| comment | text       | null: false                    |
| user_id | references | null: false, foreign_key: true |
| item_id | references | null: false, foreign_key: true |

### Association

- belongs_to : user
- belongs_to :item

## likes テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user_id | references | null: false, foreign_key: true |
| item_id | references | null: false, foreign_key: true |

### Association

- belongs_to : user
- belongs_to : item
