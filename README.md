<p align="center">
<a>　</a>
<a><a href="https://www.ruby-lang.org/ja/"><img src="https://user-images.githubusercontent.com/39142850/71774533-1ddf1780-2fb4-11ea-8560-753bed352838.png" width="70px;" /></a>
<a>　</a>
<a><a href="https://rubyonrails.org/"><img src="https://user-images.githubusercontent.com/39142850/71774548-731b2900-2fb4-11ea-99ba-565546c5acb4.png" height="60px;" /></a><br><br>
<a>　</a><a>　</a>
<a><a href="http://haml.info/"><img src="https://user-images.githubusercontent.com/39142850/71774618-b32edb80-2fb5-11ea-9050-d5929a49e9a5.png" height="60px;" /></a>
<a>　</a>
<a><a href="https://sass-lang.com/"><img src="https://user-images.githubusercontent.com/39142850/71774644-115bbe80-2fb6-11ea-822c-568eabde5228.png" height="60px" /></a>
<a>　</a>
<a><a href="https://jquery.com/"><img src="https://user-images.githubusercontent.com/39142850/71774768-d064a980-2fb7-11ea-88ad-4562c59470ae.png" height="65px;" /></a>
<a>　</a>
<a><a href="https://aws.amazon.com/"><img src="https://user-images.githubusercontent.com/39142850/71774786-37825e00-2fb8-11ea-8b90-bd652a58f1ad.png" height="60px;" /></a>
</p><br>
<h3 align="center">- Contributors -</h3>
<p align="center">
<b><a><a href="https://github.com/aocattleya"><img src="https://avatars2.githubusercontent.com/u/39142850" width="100px;" /></a></b><a>　</a>
<b><a><a href="https://github.com/mstbeat"><img src="https://avatars3.githubusercontent.com/u/57166192?s=460&v=4" width="100px;" /></a></b><a>　</a>
<b><a><a href="https://github.com/hiro-forest"><img src="https://avatars2.githubusercontent.com/u/57346263?s=460&v=4" width="100px;" /></a></b><a>　</a>
<b><a><a href="https://github.com/sawayu"><img src="https://avatars2.githubusercontent.com/u/57563734?s=460&v=4" width="100px;" /></a></b><a>　</a>
<b><a><a href="https://github.com/jku0704"><img src="https://avatars0.githubusercontent.com/u/56948201?s=460&v=4" width="100px;" /></a></b>
<br><br><br><br>

<h2 align="center">Database design</h2>

![ER](https://user-images.githubusercontent.com/39142850/70198638-bafb2600-1752-11ea-83b7-fa267ca9e76f.png)

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
| profile         | text       |                                |
| image           | string     |                                |

### Association

- has_many :comments
- has_many :likes
- has_many :items
- has_many :ordercomments
- has_many :addresses
- has_many :users_transacts
- has_many :transacts, through::users_transacts

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

- has_many :images
- has_many :comments
- has_many :likes
- has_many :orders
- belongs_to :user
- belongs_to :category
- belongs_to :brand

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

- belongs_to :user

## users_transacts テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| user_id     | references | null: false, foreign_key: true |
| transact_id | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :transact

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

- has_many :users_transacts
- belongs_to :user
- belongs_to :item

## ordercomments テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| comment  | text       | null: false                    |
| user_id  | references | null: false, foreign_key: true |
| order_id | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :order

## orders テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| state   | integer    | null: false, dafault: 0        |
| item_id | references | null: false, foreign_key: true |

### Association

- has_many :ordercomments
- belongs_to :item

## categories テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| name     | string     | null: false, index: true       |
| ancestry | integer    | index: true                    |
| item_id  | references | null: false, foreign_key: true |

### Association

- has_many :items
- has_many :brands_categories

## brands テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| name    | string     | null: false, index: true       |
| item_id | references | null: false, foreign_key: true |

### Association

- has many :items
- has many :categories, through brands_categories

## brands_categories テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| brand_id    | references | null: false, foreign_key: true |
| category_id | references | null: false, foreign_key: true |

### Association

- belongs_to :brand
- belongs_to :category

## images テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| image   | string     | null: false                    |
| item_id | references | null: false, foreign_key: true |

### Association

- belongs_to :item

## comments テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| comment | text       | null: false                    |
| user_id | references | null: false, foreign_key: true |
| item_id | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item

## likes テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user_id | references | null: false, foreign_key: true |
| item_id | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
