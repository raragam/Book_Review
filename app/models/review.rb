class Review < ApplicationRecord

  belongs_to :user

  has_many :tags, dependent: :destroy

  has_many :review_comments, dependent: :destroy
  has_many :review_favorites, dependent: :destroy

  has_one_attached :image

  validates :review_title, presence: true
  validates :review_body, presence: true
  validates :review_body, length: { minimum: 1 }
  validates :book_name, presence: true

  #ブックマーク機能

  def favorited_by?(user)
    review_favorites.exists?(user_id: user.id)
  end

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/20200501_noimage.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def self.search_for(content, method)
    if method == 'perfect'
      Review.where(review_title: content)
    elsif method == 'forward'
      Review.where('review_title LIKE ?', content+'%')
    elsif method == 'backward'
      Review.where('review_title LIKE ?', '%'+content)
    else
      Review.where('review_title LIKE ?', '%'+content+'%')
    end
  end

  #閲覧数
  is_impressionable counter_cache: true

end
