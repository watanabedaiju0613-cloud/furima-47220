class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
  KANA_REGEX = /\A[ァ-ヶー]+\z/

  with_options presence: true do
    validates :nickname
    validates :birthday
    validates :last_name,       format: { with: NAME_REGEX, message: 'は全角（漢字・ひらがな・カタカナ）で入力してください' }
    validates :first_name,      format: { with: NAME_REGEX, message: 'は全角（漢字・ひらがな・カタカナ）で入力してください' }
    validates :last_name_kana,  format: { with: KANA_REGEX, message: 'は全角カタカナで入力してください' }
    validates :first_name_kana, format: { with: KANA_REGEX, message: 'は全角カタカナで入力してください' }
  end

  validates :password, format: { with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください' }
end
