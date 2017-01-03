class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :release_year, presence: true, if: "released"
  validates :release_year, numericality: { less_than_or_equal_to: Time.now.year }, allow_nil: true

  #Cannot be repeated by the same artist in the same year
  validate :not_same_artist_name_year

  def not_same_artist_name_year
    answer = Song.all.any? do |song|
      (song.artist_name == self.artist_name) &&
      (song.release_year == self.release_year) &&
      (song.title == self.title)
    end

    errors.add(:title, "cannot include title") if answer
  end




end


  #
  # validate :content_doesnt_include_dog
  #
  # def content_doesnt_include_dog
  #   if content.downcase.include?(‘dog’)
  #         errors.add(:content, “cannot include the word dog”)
  #     end
  # end
