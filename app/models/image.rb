class Image < ActiveRecord::Base
   has_attached_file :item,
                    :storage => :s3,
                    # :s3_credentials => Proc.new{|a| a.instance.s3_credentials }, 
                    styles: { medium: "800x800>", thumb: "300x300>" }, 
                    default_url: ":styles/get_tradie.png"
  validates_attachment_content_type :item, content_type: /\Aimage\/.*\Z/
  validates_attachment_size :item, less_than: 2.megabytes

  belongs_to :user
end
