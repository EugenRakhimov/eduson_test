require 'uri'
class Exponat < ActiveRecord::Base
  belongs_to :user
  validates :link, presence: true
  validate :is_link_a_url?

  def is_link_a_url?
    uri = URI.parse(link)
    if (uri.kind_of?(URI::HTTP))
      return true
    else      
      errors.add(:link, "should be URL")
      return false
    end
    rescue URI::InvalidURIError
      false
  end
end
