require 'spec_helper'
require 'json'

describe Gobble::ShimServer, :type => :rack do

  context "no loaded responses" do
    it "should fail incoming requests" do
      get '/'
      last_response.ok?.should be_false
    end
  end

  context "manipulating resources" do
    it "should list loaded responses" do
      get '/gobble-server/responses'
      last_response.ok?.should be_true
      last_response.body.should eql("[]")
    end

    it "should accept valid response JSON blobs and store them" do
      data = [200, {'Content-Type' => 'application/json'}, ['{"id": 1}']]
      post '/gobble-server/responses', data.to_json
      last_response.ok?.should be_true

      get '/gobble-server/responses'
      last_response.ok?.should be_true
      last_response.body.should eql([data].to_json)
    end
  end

  context "with loaded responses" do
    before do
      post '/gobble-server/responses', [200, {'Content-Type' => 'application/json'}, '{"id": 1}'].to_json
      post '/gobble-server/responses', [200, {'Content-Type' => 'application/json'}, '{"id": 2}'].to_json
    end

    it "should play back loaded requests" do
      get '/product/1'
      last_response.ok?.should == true
      last_response.body.should eql('{"id": 1}')

      get '/product/2'
      last_response.ok?.should == true
      last_response.body.should eql('{"id": 2}')
    end
  end

end
