class Movie < ActiveRecord::Base
  def self.getMovieRatings
    ['G','PG','PG-13','R']
  end
end
