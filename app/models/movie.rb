class Movie < ActiveRecord::Base

  mount_uploader :image, ImageUploader

  has_many :reviews
  
  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :description,
    presence: true

  validates :runtime_in_minutes,
    presence: true,
    numericality: { integer_only: true }

  validates :poster_image_url,
    presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_past

  def self.search(search)
    if search
      where("title LIKE ?", "%#{search}%")
    end
  end

  def review_average
    reviews.sum(:rating_out_of_ten)/reviews.size
  end

  protected

  # custom validation
  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end

end

