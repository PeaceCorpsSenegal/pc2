class Website < ActiveRecord::Base

  acts_as_taggable_on :tags
  
  belongs_to :user

  validates :user_id, :name, :url, :presence => true

  def to_param
    "#{id}-#{name.parameterize}"
  end

end
