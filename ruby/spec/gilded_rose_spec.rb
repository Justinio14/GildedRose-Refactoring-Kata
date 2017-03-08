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
      let(:item) { Item.new(name= "Sulfuras, Hand of Ragnaros", sell_in= 10, quality = 70)}
      it "sell_in will not change and quality will equal 80" do
        gilded_rose.update_quality
        expect(gilded_rose.sell_in).to eq(10)
        expect(gilded_rose.quality).to eq(80)
      end
    end

  context "Aged Brie scenarios" do
      let(:item) { Item.new(name= "Aged Brie", sell_in= 10, quality = 20)}
      it "sell_in will decrease and quality will increase" do
        gilded_rose.update_quality
        expect(gilded_rose.sell_in).to eq(9)
        expect(gilded_rose.quality).to eq(21)
      end

    describe "Testing quality cap" do
      let(:item) { Item.new(name= "Aged Brie", sell_in= 10, quality = 50)}
      it "quality will not go beyond 50" do
        gilded_rose.update_quality
        expect(gilded_rose.sell_in).to eq(9)
        expect(gilded_rose.quality).to eq(50)
      end
    end
  end

  context "Backstage passes to a TAFKAL80ETC concert scenarios" do
    let(:item) { Item.new(name= "Backstage passes to a TAFKAL80ETC concert", sell_in= 15, quality = 20)}
    it "sell_in and quality will decrase by 1 when > 10 days" do
      gilded_rose.update_quality
      expect(gilded_rose.sell_in).to eq(14)
      expect(gilded_rose.quality).to eq(21)
    end
  end

  context "Backstage passes to a TAFKAL80ETC concert scenarios < 10 days" do
    let(:item) { Item.new(name= "Backstage passes to a TAFKAL80ETC concert", sell_in= 10, quality = 20)}
    it "sell_in and quality will decrase by 1 when < 10 days" do
      gilded_rose.update_quality
      expect(gilded_rose.sell_in).to eq(9)
      expect(gilded_rose.quality).to eq(22)
    end
  end

  context "Backstage passes to a TAFKAL80ETC concert scenarios" do
    let(:item) { Item.new(name= "Backstage passes to a TAFKAL80ETC concert", sell_in= 5, quality = 20)}
    it "sell_in and quality will decrase by 1 when < 5 days" do
      gilded_rose.update_quality
      expect(gilded_rose.sell_in).to eq(4)
      expect(gilded_rose.quality).to eq(23)
    end
  end

  context "Backstage passes to a TAFKAL80ETC concert scenarios" do
    let(:item) { Item.new(name= "Backstage passes to a TAFKAL80ETC concert", sell_in= 0, quality = 20)}
    it "sell_in will decrase by 1 when and quality will be 0 if days < 0 " do
      gilded_rose.update_quality
      expect(gilded_rose.sell_in).to eq(-1)
      expect(gilded_rose.quality).to eq(0)
    end
  end

  context "Backstage passes to a TAFKAL80ETC concert scenarios" do
    let(:item) { Item.new(name= "Backstage passes to a TAFKAL80ETC concert", sell_in= 15, quality = 50)}
    it "quality will exceed 50" do
      gilded_rose.update_quality
      expect(gilded_rose.quality).to eq(50)
    end
  end

  context "Backstage passes to a TAFKAL80ETC concert scenarios" do
    let(:item) { Item.new(name= "Backstage passes to a TAFKAL80ETC concert", sell_in= 10, quality = 49)}
    it "quality will exceed 50 if sell_in <= 10 days" do
      gilded_rose.update_quality
      expect(gilded_rose.sell_in).to eq(9)
      expect(gilded_rose.quality).to eq(50)
    end
  end

  context "Backstage passes to a TAFKAL80ETC concert scenarios" do
    let(:item) { Item.new(name= "Backstage passes to a TAFKAL80ETC concert", sell_in= 5, quality = 48)}
    it "quality will exceed 50 if sell_in <= 5 days" do
      gilded_rose.update_quality
      expect(gilded_rose.sell_in).to eq(4)
      expect(gilded_rose.quality).to eq(50)
    end
  end

  context "Conjured items" do
    let(:item) { Item.new(name= "Conjured", sell_in= 10, quality = 20)}
    it "quality will redcue by 2 if sell_in >= 0" do
      expect(gilded_rose.update_quality).to eq(18)
    end
  end

  context "Conjured items" do
    let(:item) { Item.new(name= "Conjured", sell_in= 10, quality = 1)}
    it "quality will not go below zero if sell_in > 0" do
      gilded_rose.update_quality
      expect(gilded_rose.sell_in).to eq(9)
      expect(gilded_rose.quality).to eq(0)
    end
  end

  context "Conjured items" do
    let(:item) { Item.new(name= "Conjured", sell_in= 0, quality = 10)}
    it "quality will reduce by 4 if sell_in < 0" do
      gilded_rose.update_quality
      expect(gilded_rose.sell_in).to eq(-1)
      expect(gilded_rose.quality).to eq(6)
    end
  end

  context "Conjured items" do
    let(:item) { Item.new(name= "Conjured", sell_in= 0, quality = 2)}
    it "quality will not go below zero sell_in < 0" do
      gilded_rose.update_quality
      expect(gilded_rose.sell_in).to eq(-1)
      expect(gilded_rose.quality).to eq(0)
    end
  end

end
