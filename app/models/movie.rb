class Movie < ActiveRecord::Base
  def self.list_ratings
    Movie.select("DISTINCT rating").order(:rating).map(&:rating)
  end
end
