require 'spec_helper'

describe RelationshipsController do

  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }

  before { sign_in user }

  describe "creating a relationship with AJAX" do

    it "should increment the relationship count" do
      expect do
        xhr :post, :create, relationship: { followed_id: other_user.id }
      end.should change(Relationship, :count).by(1)
    end

    it "should return successful" do
      xhr :post, :create, relationship: { followed_id: other_user.id }
      response.should be_success
    end

  end

  describe "destroying a relationship with AJAX" do
    before { user.follow!(other_user) }
    let(:relationship) { user.relationships.find_by_followed_id(other_user.id) }

    it "should decrement the relationship count" do
      expect do
        xhr :delete, :destroy, id: relationship.id
      end.should change(Relationship, :count).by(-1)
    end

    it "should return successful" do
      xhr :delete, :destroy, id: relationship.id
      response.should be_success
    end
  end


end
