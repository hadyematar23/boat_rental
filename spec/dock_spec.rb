require './lib/boat'
require './lib/renter'
require './lib/dock'

RSpec.describe Dock do 
  context "happy paths" do 
    let(:kayak){Boat.new(:kayak, 20)}
    let(:patrick){Renter.new("Patrick Star", "4242424242424242")}
    let(:dock){Dock.new("The Rowing Dock", 3)}
    let(:kayak_1){Boat.new(:kayak, 20)}
    let(:kayak_2){Boat.new(:kayak, 20)}
    let(:sup_1){Boat.new(:standup_paddle_board, 15)}
    let(:eugene){Renter.new("Eugene Crabs", "1313131313131313")}
    let(:canoe){Boat.new(:canoe, 25)}
    let(:sup_2){Boat.new(:standup_paddle_board, 15)}

      it "is a dock" do 
        expect(dock).to be_an_instance_of(Dock)
      end

      it "has a name" do 
        expect(dock.name)
      end

      it "has a max rental time" do 
        expect(dock.max_rental_time).to eq(3)
      end

      it "the dock can accept rentals" do 
        dock.rent(kayak, patrick)
        expect(kayak.rented_by).to eq(patrick)
      end

      it "can list a log of rentals and their owners" do 
        dock.rent(kayak, patrick)
        expect(dock.rental_log).to eq({
          kayak => patrick
        })
      end

      it "works with several different boats and renters" do 
        dock.rent(kayak_1, patrick) 
        dock.rent(kayak_2, patrick) 
        dock.rent(sup_1, eugene)  

        expect(dock.rental_log).to eq({
          kayak_1 => patrick, 
          kayak_2 => patrick, 
          sup_1 => eugene
        })
      end

      it "charges dynamically for the first kayak" do 
        dock.rent(kayak_1, patrick) 
        dock.rent(kayak_2, patrick) 
        dock.rent(sup_1, eugene) 
        kayak_1.add_hour
        kayak_1.add_hour

        expect(dock.charge(kayak_1)).to eq({
          :card_number => "4242424242424242",
          :amount => 40
        })
      end

      it "only charges up to three hours" do 
        dock.rent(kayak_1, patrick) 
        dock.rent(kayak_2, patrick) 
        dock.rent(sup_1, eugene) 
        kayak_1.add_hour
        kayak_1.add_hour
        sup_1.add_hour
        sup_1.add_hour
        sup_1.add_hour
        sup_1.add_hour
        sup_1.add_hour

        expect(dock.charge(sup_1)).to eq({
          :card_number => "1313131313131313",
          :amount => 45
        }
          
        )
      end

      it "revenue is not generated until boats are returned" do 
        dock.rent(kayak_1, patrick)
        dock.rent(kayak_2, patrick)
        dock.log_hour
        dock.rent(canoe, patrick)
        dock.log_hour
        
        expect(dock.revenue).to eq(0)

      end

      it "some revenue is generated" do 
        dock.rent(kayak_1, patrick)
        dock.rent(kayak_2, patrick)
        dock.log_hour
        dock.rent(canoe, patrick)
        dock.log_hour
        dock.return(kayak_1)
        dock.return(kayak_2)
        dock.return(canoe)
        
        expect(dock.revenue).to eq(105)

      end

      it "some revenue is generated" do 
        dock.rent(kayak_1, patrick)
        dock.rent(kayak_2, patrick)
        dock.log_hour
        dock.rent(canoe, patrick)
        dock.log_hour
        dock.return(kayak_1)
        dock.return(kayak_2)
        dock.return(canoe)
        dock.rent(sup_1, eugene)
        dock.rent(sup_2, eugene)
        dock.log_hour
        dock.log_hour
        dock.log_hour
        dock.log_hour
        dock.log_hour
        dock.return(sup_1)
        dock.return(sup_2)

        
        expect(dock.revenue).to eq(195)

      end



  end 
end 