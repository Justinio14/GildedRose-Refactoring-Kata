require './gilded_rose'

describe GildedRose do

  let(:gilded_rose) {described_class.new([item])}



  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end
  end


  context "Non specialized items before sell in date passed" do
    let(:item) { Item.new(name= "Bread", sell_in= 5, quality = 10)}
      it "reduces sell_in by 1" do
        expect{ gilded_rose.update_quality}.to change{item.sell_in}.by (-1)
      end

      it "reduces quality by 1" do
        expect{ gilded_rose.update_quality}.to change{item.quality}.by (-1)
      end
  end

    context "Non specialized items after sell in date passed" do
      let(:item) { Item.new(name= "Bread", sell_in= 0, quality = 10)}
      it "quality degrades by 2" do
        expect{ gilded_rose.update_quality}.to change{item.quality}.by (-2)
      end
    end

    context "Non specialized items check quality floor" do
      let(:item) { Item.new(name= "Bread", sell_in= 10, quality = 0)}
      it "quality dcannot be less than zero" do
        expect{ gilded_rose.update_quality}.not_to change{item.quality}
      end
    end

end
