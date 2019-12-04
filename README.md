# Mercari-clone DB設計

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

- has_many
- has_many
- has_many

## items テーブル

| Column          | Type       | Options                         |
| --------------- | ---------- | ------------------------------- |
| name            | string     | null: false, index: true        |
| price           | integer    | null: false, index: true        |
| size            | string     |                                 |
| condition       | string     | null: false                     |
| shipping_date   | integer    | null: false                     |
| shipping_price  | integer    | null: false                     |
| shipping_area   | string     | null: false                     |
| shipping_method | string     | null: false                     |
| category_id     | references | null: false , foreign_key: true |
| brand_id        | references | null: false, foreign_key: true  |
| user_id         | references | null: false, foreign_key: true  |

### Association

- has_many
- has_many
- has_many

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

- belongs_to
- belongs_to

## users_transacts テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| user_id     | references | null: false, foreign_key: true |
| transact_id | references | null: false, foreign_key: true |

### Association

- belongs_to
- belongs_to

## transacts テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| evaluate  | string     | null: false                    |
| confirm   | boolean    | null: false                    |
| body      | text       | null: false                    |
| seller_id | references | null: false, foreign_key: true |
| buyer_id  | references | null: false, foreign_key: true |
| item_id   | references | null: false, foreign_key: true |

### Association

- belongs_to
- belongs_to

## ordercomments テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| comment  | text       | null: false                    |
| user_id  | references | null: false, foreign_key: true |
| order_id | references | null: false, foreign_key: true |

### Association

- belongs_to
- belongs_to

## orders テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| state   | integer    | null: false                    |
| item_id | references | null: false, foreign_key: true |

### Association

- belongs_to
- belongs_to

## categories テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| name     | string     | null: false, index: true       |
| ancestry | integer    | index: true                    |
| item_id  | references | null: false, foreign_key: true |

### Association

- belongs_to
- belongs_to

## brands テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| name    | string     | null: false, index: true       |
| item_id | references | null: false, foreign_key: true |

### Association

- belongs_to
- belongs_to

## brands_categories テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| brand_id    | references | null: false, foreign_key: true |
| category_id | references | null: false, foreign_key: true |

### Association

- belongs_to
- belongs_to

## images テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| image   | string     | null: false                    |
| item_id | references | null: false, foreign_key: true |

### Association

- belongs_to
- belongs_to

## comments テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| comment | text       |                                |
| user_id | references | null: false, foreign_key: true |
| item_id | references | null: false, foreign_key: true |

### Association

- belongs_to
- belongs_to

## likes テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user_id | references | null: false, foreign_key: true |
| item_id | references | null: false, foreign_key: true |

### Association

- belongs_to
- belongs_to
