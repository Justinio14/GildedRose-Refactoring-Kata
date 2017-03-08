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


  context "standard items before sell in date passed" do
    let(:item) { Item.new(name= "Bread", sell_in= 5, quality = 10)}
      it "reduces sell_in and quality by 1" do
        gilded_rose.update_quality
        expect(gilded_rose.sell_in).to eq(4)
        expect(gilded_rose.quality).to eq(9)
      end
  end

    context "standard items after sell in date passed" do
      let(:item) { Item.new(name= "Bread", sell_in= 0, quality = 10)}
      it "quality degrades by 2" do
        gilded_rose.update_quality
        expect(gilded_rose.sell_in).to eq(-1)
        expect(gilded_rose.quality).to eq(8)
      end
    end

    context "standard items quality floor at zero" do
      let(:item) { Item.new(name= "Bread", sell_in= 10, quality = 0)}
      it "quality cannot be less than zero when sell_in is positive" do
        gilded_rose.update_quality
        expect(gilded_rose.sell_in).to eq(9)
        expect(gilded_rose.quality).to eq(0)
      end
    end

    context "standard items quality floor at zero" do
      let(:item) { Item.new(name= "Bread", sell_in= 0, quality = 1)}
      it "quality cannot be less than zero when sell_in is negative" do
        gilded_rose.update_quality
        expect(gilded_rose.sell_in).to eq(-1)
        expect(gilded_rose.quality).to eq(0)
      end
    end

    context "standard items quality floor at zero" do
      let(:item) { Item.new(name= "Bread", sell_in= 10, quality = 0)}
      it "quality cannot be less than zero" do
        gilded_rose.update_quality
        expect(gilded_rose.sell_in).to eq(9)
        expect(gilded_rose.quality).to eq(0)
      end
    end


    context "Sulfuras, Hand of Ragnaros scenarios" do
      let(:item) { Item.new(name= "Sulfuras, Hand of Ragnaros", sell_in= 10, quality = 80)}
      it "sell_in and quality will not change" do
        expect{ gilded_rose.update_quality}.not_to change{item.sell_in}
        expect{ gilded_rose.update_quality}.not_to change{item.quality}
        expect(item.quality).to eq(80)
      end
    end

  context "Aged Brie scenarios" do
      let(:item) { Item.new(name= "Aged Brie", sell_in= 10, quality = 20)}
      it "sell_in will decrease and quality will increase" do
        expect{ gilded_rose.update_quality}.to change{item.sell_in}.by(-1)
        expect{ gilded_rose.update_quality}.to change{item.quality}.by(1)
      end

    describe "Testing quality cap" do
      let(:item) { Item.new(name= "Aged Brie", sell_in= 10, quality = 50)}
      it "quality will go beyond 50" do
        expect{ gilded_rose.update_quality}.not_to change{item.quality}
      end
    end
  end

  context "Backstage passes to a TAFKAL80ETC concert scenarios" do
    let(:item) { Item.new(name= "Backstage passes to a TAFKAL80ETC concert", sell_in= 15, quality = 20)}
    it "sell_in and quality will decrase by 1 when > 10 days" do
      expect{ gilded_rose.update_quality}.to change{item.sell_in}.by(-1)
      expect{ gilded_rose.update_quality}.to change{item.quality}.by(1)
    end
  end

  context "Backstage passes to a TAFKAL80ETC concert scenarios < 10 days" do
    let(:item) { Item.new(name= "Backstage passes to a TAFKAL80ETC concert", sell_in= 10, quality = 20)}
    it "sell_in and quality will decrase by 1 when < 10 days" do
      expect{ gilded_rose.update_quality}.to change{item.quality}.by(2)
    end
  end

  context "Backstage passes to a TAFKAL80ETC concert scenarios" do
    let(:item) { Item.new(name= "Backstage passes to a TAFKAL80ETC concert", sell_in= 5, quality = 20)}
    it "sell_in and quality will decrase by 1 when < 5 days" do
      expect{ gilded_rose.update_quality}.to change{item.sell_in}.by(-1)
      expect{ gilded_rose.update_quality}.to change{item.quality}.by(3)
    end
  end

  context "Backstage passes to a TAFKAL80ETC concert scenarios" do
    let(:item) { Item.new(name= "Backstage passes to a TAFKAL80ETC concert", sell_in= 0, quality = 20)}
    it "sell_in will decrase by 1 when and quality will be 0 if days < 0 " do
      expect{ gilded_rose.update_quality}.to change{item.sell_in}.by(-1)
      expect(item.quality).to eq(0)
    end
  end

end
