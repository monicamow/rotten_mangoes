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

  # scopes
  scope :less_than, -> (minutes) { where("runtime_in_minutes < ?", minutes) }
  scope :greater_than, -> (minutes) { where("runtime_in_minutes > ?", minutes) }

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

  # search by duration

  def self.search_duration(search)
    case search
    when "Under 90 minutes"
      search_results = Movie.less_than(90)
    when "Between 90 and 120 minutes"
      search_results = Movie.less_than(120).greater_than(90)
    when "Over 120 minutes"
      search_results = Movie.greater_than(120)
    else
      "WHAT?"
    end
    search_results
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

