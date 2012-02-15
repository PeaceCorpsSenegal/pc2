class Document < ActiveRecord::Base

  has_attached_file :file
  validates_attachment_presence :file
  acts_as_taggable_on :tags

  belongs_to :user
  belongs_to :language
  belongs_to :attachable, :polymorphic => true
  
  has_many :stacks, :as => :stackable, :dependent => :destroy

  accepts_nested_attributes_for :stacks
  
  validates :name, :presence => true

  before_validation :clear_empty_attrs

  private

    def clear_empty_attrs
      @attributes.each do |key,value|
        self[key] = nil if value.blank?
      end
      self.name = self.file_file_name if name.nil?
    end

end
