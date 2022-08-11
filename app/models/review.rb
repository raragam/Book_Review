class Review < ApplicationRecord

  belongs_to :user

  has_many :review_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_one_attached :image

  validates :review_title, presence: true
  validates :review_body, presence: true
  validates :review_body, length: { minimum: 1, maximum: 200 }
  #validates :book_name, presence: true

  # def get_profile_image
  #   unless profile_image.attached?
  #     file_path = Rails.root.join('app/assets/images/no_image.jpg')
  #     profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  #   end
  #   profile_image.variant(resize_to_limit: [100, 100]).processed
  # end

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
