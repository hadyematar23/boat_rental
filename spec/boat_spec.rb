require './lib/boat'
require './lib/renter'

RSpec.describe Boat do 
  context "happy paths" do 
    let(:kayak){Boat.new(:kayak, 20)}
    let(:renter){Renter.new("Patrick Star", "4242424242424242")}

    it "is a boat" do 
      expect(kayak).to be_an_instance_of(Boat)

    end

    it "has a type" do 
      expect(kayak.type).to eq(:kayak)
    end

    it "has a price per hour" do 
      expect(kayak.price_per_hour).to eq(20)
    end

    it "starts off with no hours rented" do 
      expect(kayak.hours_rented).to eq(0)
    end

    it "each hour adds one hour rented" do 
      kayak.add_hour
      kayak.add_hour
      kayak.add_hour

      expect(kayak.hours_rented).to eq(3)
    end

    
  end
end