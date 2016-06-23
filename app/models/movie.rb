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

  # scopes
  # for searching by title
  scope :search_title, -> (title_input) { where("title LIKE ?", "%#{title_input}%") }
  scope :search_director, -> (director_input) { where("director LIKE ?", "%#{director_input}%") }
  # for searching by duration
  scope :less_than, -> (minutes) { where("runtime_in_minutes < ?", minutes) }
  scope :greater_than, -> (minutes) { where("runtime_in_minutes > ?", minutes) }

  def self.search(search)
    if search[:title].present?
      search_results = Movie.search_title(search[:title])
    end
    
    if search[:director].present?
      search_results = Movie.search_director(search[:director])
    end
    search_results
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

