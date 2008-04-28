require File.dirname(__FILE__) + '/spec_helper'

describe ActiveRecord::Base, "#relates_to" do
  before(:each) do
    @user = RelatableUser.create(:name => "Testy")
    @forum = RelatableForum.create(:name => "Talky")
  end
  
  it "should create relationships based on #relates_to calls" do
    # based on this line from spec_helper:
    # relates_to :forums, :map => {:administered => :administrator, :moderated => :moderator}
    @user.relator_relationships.should == []
    @user.relatable_forums.should == []
  end
  
  it "should be able to create a relationship through instance #relates_to" do
    (r = @user.relates_to(@forum)).is_a?(Relationship).should be_true
    @user.relator_relationships.first.should == @forum.related_relationships.first
    @user.relatable_forums.size.should == 1
    @forum.relatable_users.size.should == 1
  end
  
  it "should create scoped finders based on the nature mappings" do
    
  end
end
