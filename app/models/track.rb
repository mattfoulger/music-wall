class Track < ActiveRecord::Base
  belongs_to :user
  has_many :upvotes

  validates_presence_of :song_title, :author, :user_id

  # def upvote_count
  #   self.upvotes.count
  # end


end