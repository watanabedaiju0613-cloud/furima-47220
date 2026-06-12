require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  it '全項目が正しければ登録できる' do
    expect(@user).to be_valid
  end

  it 'nicknameが空では登録できない' do
    @user.nickname = ''
    @user.valid?
    expect(@user.errors.full_messages).to include("Nickname can't be blank")
  end

  it 'emailが空では登録できない' do
    @user.email = ''
    @user.valid?
    expect(@user.errors.full_messages).to include("Email can't be blank")
  end

  it '重複したemailは登録できない' do
    @user.save
    another = FactoryBot.build(:user, email: @user.email)
    another.valid?
    expect(another.errors.full_messages).to include('Email has already been taken')
  end

  it 'passwordが空では登録できない' do
    @user.password = ''
    @user.valid?
    expect(@user.errors.full_messages).to include("Password can't be blank")
  end

  it 'passwordが5文字以下では登録できない' do
    @user.password = @user.password_confirmation = 'a1a1a'
    @user.valid?
    expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
  end

  it 'passwordが英字のみでは登録できない' do
    @user.password = @user.password_confirmation = 'aaaaaa'
    @user.valid?
    expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
  end

  it 'last_nameが全角でないと登録できない' do
    @user.last_name = 'yamada'
    @user.valid?
    expect(@user.errors.full_messages).to include('Last name は全角（漢字・ひらがな・カタカナ）で入力してください')
  end

  it 'last_name_kanaが全角カタカナでないと登録できない' do
    @user.last_name_kana = 'やまだ'
    @user.valid?
    expect(@user.errors.full_messages).to include('Last name kana は全角カタカナで入力してください')
  end

  it 'birthdayが空では登録できない' do
    @user.birthday = ''
    @user.valid?
    expect(@user.errors.full_messages).to include("Birthday can't be blank")
  end
end 