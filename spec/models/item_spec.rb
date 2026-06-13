require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  it '全項目が正しければ出品できる' do
    expect(@item).to be_valid
  end

  it '画像が空では出品できない' do
    @item.image = nil
    @item.valid?
    expect(@item.errors.full_messages).to include("Image can't be blank")
  end

  it 'nameが空では出品できない' do
    @item.name = ''
    @item.valid?
    expect(@item.errors.full_messages).to include("Name can't be blank")
  end

  it 'infoが空では出品できない' do
    @item.info = ''
    @item.valid?
    expect(@item.errors.full_messages).to include("Info can't be blank")
  end

  it 'category_idが1では出品できない' do
    @item.category_id = 1
    @item.valid?
    expect(@item.errors.full_messages).to include("Category can't be blank")
  end

  it 'sales_status_idが1では出品できない' do
    @item.sales_status_id = 1
    @item.valid?
    expect(@item.errors.full_messages).to include("Sales status can't be blank")
  end

  it 'priceが空では出品できない' do
    @item.price = ''
    @item.valid?
    expect(@item.errors.full_messages).to include("Price can't be blank")
  end

  it 'priceが300未満では出品できない' do
    @item.price = 299
    @item.valid?
    expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
  end

  it 'priceが数値でないと出品できない' do
    @item.price = 'aaa'
    @item.valid?
    expect(@item.errors.full_messages).to include('Price is not a number')
  end

  it 'userが紐付いていないと出品できない' do
    @item.user = nil
    @item.valid?
    expect(@item.errors.full_messages).to include('User must exist')
  end
end
