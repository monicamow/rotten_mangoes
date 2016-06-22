class Review < ActiveRecord::Base

  belongs_to :user
  belongs_to :movie

  validates :user,
    presence: true

  validates :movie,
    presence: true

  validates :text,
    presence: true

  validates :rating_out_of_ten,
    presence: true,
    numericality: { 
      integer_only: true, 
      greater_than_or_equal_to: 1,
      less_than_or_equal_to: 10
      }

end
