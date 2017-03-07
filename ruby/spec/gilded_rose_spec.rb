require './gilded_rose'

describe GildedRose do

  let(:gilded_rose) {described_class.new([item])}
  let(:item) { Item.new(name= "Bread", sell_in= 5, quality = 10)}

  it "reduces sell_in by 1" do
    expect{ gilded_rose.update_quality}.to change{item.sell_in}.by (-1)
  end



  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end
  end

  describe "standard item reduction" do

  end

end
