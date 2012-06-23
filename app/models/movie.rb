class Movie < ActiveRecord::Base
  has_many :reviews
  has_many :users, :through => :reviews

  RATINGS = %w[G PG PG-13 R NC-17]  #  %w[] shortcut for array of strings
  validates :title, :presence => true
  validates :release_date, :presence => true
  validate :released_1930_or_later # uses custom validator below
  validates :rating, :inclusion => {:in => RATINGS}, :unless => :grandfathered?
  def released_1930_or_later
    errors.add(:release_date, 'must be 1930 or later') if
       self.release_date < Date.parse('1 Jan 1930')
  end
  def grandfathered? ; self.release_date >= Date.parse('1 Nov 1968') ; end

  before_save :capitalize_title
  def capitalize_title
    self.title = self.title.split(/\s+/).map(&:downcase).map(&:capitalize).join(' ')
  end

  def self.all_ratings
    RATINGS
  end

  def self.director_for(id)
    dir = Movie.find(id).director
    return dir if dir and not dir.empty?
    return nil
  end

  def name_with_rating
    "#{title} (#{rating})"
  end
end
