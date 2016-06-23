class Movie < ActiveRecord::Base

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

  def self.search_title(search)
    unless search.blank?
      self.where("title LIKE ?", "%#{search}%")
    end
  end

  def self.search_director(search)
    unless search.blank?
      self.where("director LIKE ?", "%#{search}%")
    end
  end

  def self.search_duration_under(search)
    puts "=============== under"
    unless search.blank?
      self.where("runtime_in_minutes < ?", search.to_i)
    end
  end

  def self.search_duration_range(search)
     puts "=============== netween"
    unless search.blank?
      search_array = search.split(",")
      search_result = self.where("runtime_in_minutes > ?", search_array[0].to_i).where("runtime_in_minutes < ?", search_array[1].to_i)
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

