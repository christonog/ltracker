require 'spec_helper'

describe "The ltracker application" do
	
	its "homepage" do
		get '/'
		last_response.should be_ok

	end

	its "about page" do
		get '/about'
		last_response.should be_ok
		last_response.body.include?('About Ltracker')
	end

	it "should be ok if there is no tracking number" do
		post '/', params={number: '0'}
		last_response.should be_ok
		last_response.should match(/Sorry, not a valid tracking number/)

	end

	context "when redirecting the user to a shipping page" do


		it "redirects to the fedex website when a fedex number" do
			post '/', params={number: '913092675068220'}
			last_response.status.should == 302 #302 is a redirect, which is what the code is doing
		end
	end

	it "should get 404 page when going to invalid url" do
		get '/incorrecturl'
		last_response.should_not be_ok
		last_response.should match(/Sorry, page not found./)
	end

end