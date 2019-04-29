require "rails_helper"

RSpec.describe RoulettesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/roulettes").to route_to("roulettes#index")
    end

    it "routes to #new" do
      expect(:get => "/roulettes/new").to route_to("roulettes#new")
    end

    it "routes to #show" do
      expect(:get => "/roulettes/1").to route_to("roulettes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/roulettes/1/edit").to route_to("roulettes#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/roulettes").to route_to("roulettes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/roulettes/1").to route_to("roulettes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/roulettes/1").to route_to("roulettes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/roulettes/1").to route_to("roulettes#destroy", :id => "1")
    end
  end
end
