# README

フリーマーケットアプリ（フリマアプリ）のデータベース設計です。

## アプリ概要

フリマサイトを再現したアプリケーション。ユーザー登録後、商品の出品・購入ができる。

## ER図

`ER_diagram.mermaid` を参照（ER図作成ツールで作成した図を本番では添付）。

---

## テーブル設計

### users テーブル

| Column             | Type    | Options                    |
|--------------------|---------|----------------------------|
| nickname           | string  | null: false                |
| email              | string  | null: false, unique: true  |
| encrypted_password | string  | null: false                |
| last_name          | string  | null: false                |
| first_name         | string  | null: false                |
| last_name_kana     | string  | null: false                |
| first_name_kana    | string  | null: false                |
| birthday           | date    | null: false                |

#### Association

- has_many :items
- has_many :orders

---

### items テーブル

| Column                | Type       | Options                        |
|-----------------------|------------|--------------------------------|
| name                  | string     | null: false                    |
| info                  | text       | null: false                    |
| category_id           | integer    | null: false                    |
| sales_status_id       | integer    | null: false                    |
| shipping_fee_status_id| integer    | null: false                    |
| prefecture_id         | integer    | null: false                    |
| scheduled_delivery_id | integer    | null: false                    |
| price                 | integer    | null: false                    |
| user                  | references | null: false, foreign_key: true |

※ 商品画像は ActiveStorage で1枚添付する（カラムは持たない）。
※ category / sales_status / shipping_fee_status / prefecture / scheduled_delivery は ActiveHash で管理する。

#### Association

- belongs_to :user
- has_one :order
- belongs_to :category（ActiveHash）
- belongs_to :sales_status（ActiveHash）
- belongs_to :shipping_fee_status（ActiveHash）
- belongs_to :prefecture（ActiveHash）
- belongs_to :scheduled_delivery（ActiveHash）

---

### orders テーブル（購入記録）

| Column | Type       | Options                        |
|--------|------------|--------------------------------|
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

#### Association

- belongs_to :user
- belongs_to :item
- has_one :address

---

### addresses テーブル（配送先情報）

| Column        | Type       | Options                        |
|---------------|------------|--------------------------------|
| postal_code   | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| house_number  | string     | null: false                    |
| building_name | string     |                                |
| phone_number  | string     | null: false                    |
| order         | references | null: false, foreign_key: true |

※ prefecture は ActiveHash で管理する。
※ クレジットカード情報は DB に保存しない（PAY.JP でトークン化して扱う）。

#### Association

- belongs_to :order
- belongs_to :prefecture（ActiveHash）