class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #投稿
  has_many :opinions, dependent: :destroy
  has_many :reviews, dependent: :destroy

  #コメント
  has_many :opinion_comments, dependent: :destroy
  has_many :review_comments, dependent: :destroy

  #ブックマーク
  has_many :opinion_favorites, dependent: :destroy
  has_many :review_favorites, dependent: :destroy

  #フォロー
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  #通報
  has_many :reports, class_name: "Report", foreign_key: "reporter_id", dependent: :destroy
  has_many :reverse_of_reports, class_name: "Report", foreign_key: "reported_id", dependent: :destroy

  #プロフィール画像
  has_one_attached :profile_image

  #プロフィール画像

  def get_profile_image
    if profile_image.attached?
      profile_image.variant(resize_to_limit: [100, 100]).processed
    else
      'no_image.jpg'
    end
  end

  #フォロー機能

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  #検索機能

  def self.search_for(content, method)
    if method == 'perfect'
      User.where(name: content)
    elsif method == 'forward'
      User.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      User.where('name LIKE ?', '%' + content)
    else
      User.where('name LIKE ?', '%' + content + '%')
    end
  end

  #退会機能

  def active_for_authentication?
    super && (is_deleted == false)
  end

  #バリデーション

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: { minimum: 2, maximum: 20 }

  #これがメールアドレス用のバリデーション。テストデプロイの際はコメントアウトを外す。
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true
  validates :email, format: { with: VALID_EMAIL_REGEX }
  validates :email, uniqueness: true

  validates :password, length: { minimum: 6 }, on: :create

  # with_options if: :is_users? do |users|
  #   users.validates :password, length: { minimum: 6 }
  # end

  validates :introduction, length: { maximum: 50 }

end
