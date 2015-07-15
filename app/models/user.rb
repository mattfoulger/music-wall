class User < ActiveRecord::Base
  has_many :tracks
  has_many :upvotes

  validates_presence_of :email, :user_name, :password
  validates_uniqueness_of :email, :user_name

  def upvotes_received
    @count = 0
    self.tracks.each do |track|
      @count += track.upvotes.count
    end
    @count
  end


end