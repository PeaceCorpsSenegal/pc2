require 'spec_helper'

describe Library do
  before(:each) do
    @user = Factory(:user)
    @attr = {
      :name => 'test library name',
      :country => Factory.next(:country)
    }
  end

  it 'should create a new stack given valid attributes' do
    @user.libraries.create!(@attr)
  end

  # validation
  describe 'validation' do
    it 'should require a user_id' do
      Library.new(@attr).should_not be_valid
    end
    it 'should require a name' do
      bad = @user.libraries.build(@attr.merge(:name => nil))
      bad.should_not be_valid
    end
    it 'should require a country' do
      @user.libraries.build(@attr.merge(:country => nil)).should_not be_valid
    end
    it 'should accept tags' do
      tags = 'tag1,tag2'
      @library = @user.libraries.create(@attr.merge(:tag_list => tags))
      @library.tag_list.should == tags.split(',')
    end
  end

  # properties
  describe 'properties' do
    before(:each) do
      # stack factory, and therefore library factory, defaults to documents
      @library = Factory.create(:library, :user => @user)
    end
    it 'should respond to documents' do
      @library.should respond_to :documents
    end
    it 'should return documents' do
      Factory.create(:stack, :library => @library, :stackable => @document = Factory(:document))
      @library.documents.should == [@document]
    end
    it 'should respond to photos' do
      @library.should respond_to :photos
    end
    it 'should return photos' do
      Factory.create(:stack, :library => @library, :stackable => @photo = Factory(:photo))
      @library.photos.should == [@photo]
    end
    it 'should respond to to_param' do
      @library.should respond_to :to_param
      @library.to_param.should == "#{@library.id}-#{@library.canonical_title.parameterize}"
    end
    it 'should respond to canonical_title' do
      @library.should respond_to :canonical_title
      @library.canonical_title.should == @library.name
    end
    it 'should respond to contents' do
      @library.should respond_to :contents
    end
    it 'contents should return documents + photos' do
      Factory.create(:stack, :library => @library, :stackable => @document = Factory(:document))
      Factory.create(:stack, :library => @library, :stackable => @photo = Factory(:photo))
      @library.contents.should include(@document)
      @library.contents.should include(@photo)
    end
    it 'should respond to file_name' do
      @library.should respond_to :file_name
    end
    it 'should respond to full_name' do
      @library.should respond_to :full_name
    end
    it 'should respond to bundle' do
      @library.should respond_to :bundle
    end
    it 'bundle should return true' do
      @library.bundle.should be_true
    end
    it 'should respond to mp3s' do
      @library.should respond_to :mp3s
    end
    it 'mp3s should return only mp3 files' do
      Factory.create(:stack, :library => @library, :stackable => @mp3 = Factory(:mp3))
      Factory.create(:stack, :library => @library, :stackable => @document = Factory(:document))
      Factory.create(:stack, :library => @library, :stackable => @photo = Factory(:photo))
      @library.mp3s.should include(@mp3)
      @library.mp3s.should_not include(@document)
      @library.mp3s.should_not include(@photo)
    end
    describe 'available' do
      it 'should respond to available' do
        Library.should respond_to :available
      end
      it 'no libraries, and no user' do
        Factory.create(:stack, :library => @library_with = Factory.create(:library, :user => @user = Factory(:user)), :stackable => @photo = Factory.create(:photo))
        Factory.create(:stack, :library => @library_without = Factory.create(:library, :user => @user))
        Factory.create(:stack, :library => @library_rando = Factory.create(:library))
        @photo2 = Factory.create(:photo)
        Library.available(@photo2).should include(@library_without)
        Library.available(@photo2).should include(@library_rando)
        Library.available(@photo2).should include(@library_with)
      end
      it 'libraries, but no user' do
        Factory.create(:stack, :library => @library_with = Factory.create(:library, :user => @user = Factory(:user)), :stackable => @photo = Factory.create(:photo))
        Factory.create(:stack, :library => @library_with2 = Factory.create(:library, :user => @user), :stackable => @photo)
        Factory.create(:stack, :library => @library_without = Factory.create(:library, :user => @user))
        Factory.create(:stack, :library => @library_rando = Factory.create(:library))
        Library.available(@photo).should include(@library_without)
        Library.available(@photo).should include(@library_rando)
        Library.available(@photo).should_not include(@library_with)
        Library.available(@photo).should_not include(@library_with2)
      end
      it 'no libraries, but user' do
        Factory.create(:stack, :library => @library_with = Factory.create(:library, :user => @user = Factory(:user)), :stackable => @photo = Factory.create(:photo))
        Factory.create(:stack, :library => @library_without = Factory.create(:library, :user => @user))
        Factory.create(:stack, :library => @library_rando = Factory.create(:library))
        @photo2 = Factory.create(:photo)
        Library.available(@photo2, @user).should include(@library_without)
        Library.available(@photo2, @user).should_not include(@library_rando)
        Library.available(@photo2, @user).should include(@library_with)
      end
      it 'libraries and user' do
        Factory.create(:stack, :library => @library_with = Factory.create(:library, :user => @user = Factory(:user)), :stackable => @photo = Factory.create(:photo))
        Factory.create(:stack, :library => @library_with2 = Factory.create(:library, :user => @user), :stackable => @photo)
        Factory.create(:stack, :library => @library_without = Factory.create(:library, :user => @user))
        Factory.create(:stack, :library => @library_rando = Factory.create(:library))
        Library.available(@photo, @user).should include(@library_without)
        Library.available(@photo, @user).should_not include(@library_rando)
        Library.available(@photo, @user).should_not include(@library_with)
        Library.available(@photo, @user).should_not include(@library_with2)
      end
    end
  end

  # associations
  describe 'associations' do
    describe 'belongs_to' do
      describe 'user' do
        before(:each) do
          @library = Factory.create(:library, :user => @user)
        end
        it 'should respond to user attribute' do
          @library.should respond_to :user
        end
        it 'should return the correct user' do
          @library.user.should == @user
        end
        it 'should not destroy associated user' do
          @library.destroy
          User.find_by_id(@user.id).should_not be_nil
        end
      end
    end
    describe 'has_many' do
      describe 'stacks' do
        before(:each) do
          @library = Factory.create(:library)
          @stack = Factory.create(:stack, :library => @library)
        end
        it' should responde to stacks' do
          @library.should respond_to :stacks
        end
        it 'should return the correct stacks' do
          @library.stacks.should == [@stack]
        end
        it 'should destroy associated stacks' do
          @library.destroy
          Stack.find_by_id(@stack.id).should be_nil
        end
      end
    end
  end
end
