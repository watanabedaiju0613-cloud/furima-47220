FactoryBot.define do
  factory :item do
    name                   { 'テスト商品' }
    info                   { 'テストの説明' }
    category_id            { 2 }
    sales_status_id        { 2 }
    shipping_fee_status_id { 2 }
    prefecture_id          { 2 }
    scheduled_delivery_id  { 2 }
    price                  { 1000 }
    association :user

    after(:build) do |item|
      item.image.attach(
        io: File.open(Rails.root.join('app/assets/images/furima-logo-color.png')),
        filename: 'test_image.png'
      )
    end
  end
end
