

require 'spec_helper'

describe PagesController do

  render_views

  before(:each) do
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  describe "GET 'home'" do

    it "should be successful" do
      get 'home'
      response.should be_success
    end

    it "should have the right title" do
      get 'home'
      response.should have_selector("title", :content => @base_title + " | Home")
    end

    
    describe "for signed-in users" do 

      before(:each) do 
         @user = test_sign_in(Factory(:user)) 
         @mp1 = Factory(:micropost, :user => @user)
         
      end 

      it "should have micropost count in sidebar" do 
         get 'home' 
         response.should have_selector("span.microposts", :content => "1 micropost") 
         @mp2 = Factory(:micropost, :user => @user) 
         get 'home' 
         response.should have_selector("span.microposts", :content => "2 microposts") 
      end 
       

    end #describe for signed-in users

    describe "Display delete link" do

	before(:each) do
	  @user = test_sign_in(Factory(:user))

	  @attr = {:name => "New User", 
		:email => "user@example.com",
		:password => "foobar",
		:password_confirmation => "foobar"}
	  @other_user = Factory(:user, @attr)
	end

	describe "failure" do
		before(:each) do
			@other_micropost = Factory(:micropost, :user => @other_user)
			30.times { Factory(:micropost, :user => @other_user)}
		end

		it "should not have a delete link for another user" do
			get :home, :id => @other_user
			response.should_not have_selector("a", :content => "delete")
		end
	end

	describe "success" do
		before(:each) do
			@micropost = Factory(:micropost, :user => @user)
			30.times { Factory(:micropost, :user => @user)}
		end

		it "should have a delete link for current user" do
			get :home, :id => @user
			response.should have_selector("a", :content => "delete")
		end
	end
    end #describe Display delete

  end #describe Get home

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end

    it "should have the right title" do
      get 'contact'
      response.should have_selector("title", :content => @base_title + " | Contact")
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end

    it "should have the right title" do
      get 'about'
      response.should have_selector("title",
                                    :content => @base_title + " | About")
    end
  end

 describe "GET 'help'" do
    it "should be successful" do
      get 'help'
      response.should be_success
    end

    it "should have the right title" do
      get 'help'
      response.should have_selector("title",
                                    :content => @base_title + " | Help")
    end
 end #describe GET help
end #describe PagesController
 
