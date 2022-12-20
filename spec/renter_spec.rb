require './lib/boat'
require './lib/renter'

RSpec.describe Renter do 
  context "happy paths" do 
    let(:kayak){Boat.new(:kayak, 20)}
    let(:renter){Renter.new("Patrick Star", "4242424242424242")}

    it "there is a renter!" do 

      expect(renter).to be_an_instance_of(Renter)

    end

    it "the renter has a name" do 

      expect(renter.name).to eq("Patrick Star")

    end

    it "the renter has a credit card" do 

      expect(renter.credit_card_number).to eq("4242424242424242")

    end

  end 
end 