FactoryGirl.define do

  factory :case_study do
    sequence(:title) { |n| "Factory Generated Title #{n}" }
    summary 'Factory summary'
    country 'SN'
    language_id 1
    association :photo
  end

  factory :document do
    association :user
    country 'SN'
    file File.open(File.join(File.dirname(__FILE__), 'fixtures', 'test.txt'))
    sequence(:file_fingerprint) { |n| "#{n}#{SecureRandom.hex(10)}" }
  end

  factory :library do
    name 'Test Library'
    country 'SN'
    association :user, :factory => :user
  end

  factory :mp3, :class => Document do
    country 'SN'
    association :user, :factory => :user
    file File.open(File.join(File.dirname(__FILE__), 'fixtures', 'test.mp3'))
  end
  
  factory :page do
    sequence(:title) { |n| "Factory Generated Title #{n}" }
    description 'Description'
    content 'Content'
    language_id 1
    country 'SN'
  end

  factory :photo do
    association :user
    country 'SN'
    association :imageable, :factory => :user
    # photo { File.new(File.join(Rails.root, 'spec', 'support', 'test.png')) }
    photo File.open(File.join(File.dirname(__FILE__), 'fixtures', 'test.png'))
    sequence(:photo_fingerprint) { |n| "#{n}#{SecureRandom.hex(10)}" }
  end

  factory :stack do
    association :library
    association :user
    association :stackable, :factory => :document
  end

  factory :staff do
    country 'SN'
    association :user
  end

end
