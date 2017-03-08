class GildedRose

  attr_reader :name, :sell_in, :quality

  def initialize(items)
    @items = items
    @specials = ["Aged Brie", "Backstage passes to a TAFKAL80ETC concert", "Sulfuras, Hand of Ragnaros", "Conjured" ]
    @name = ""
    @quality = 0
    @sell_in = 0
  end

  QUALITY_FLOOR = 0
  QUALITY_CAP = 50
  SULFURAS_QUALITY = 80


  def item_display()
    @items.each do |item|
      @name = item.name
      @quality = item.quality
      @sell_in = item.sell_in
    end
  end


  def update_quality()
    item_display
    sell_in_reduce
    if @specials[0] == @name
      aged_brie
    elsif @specials[1] == @name
      backstage
    elsif @specials[2] == @name
      sulfuras
    elsif @specials[3] == @name
      conjured
    else
      standard
    end
  end

  private

    def aged_brie
      @quality < QUALITY_CAP  ? @quality += 1 : @quality = QUALITY_CAP
    end

    def sulfuras
      @quality = SULFURAS_QUALITY
    end

    def backstage
      if @sell_in < 0
        @quality = QUALITY_FLOOR
      elsif @sell_in < 6 && @quality <= (QUALITY_CAP - 3)
        @quality += 3
      elsif @sell_in < 11 && @quality <= (QUALITY_CAP - 2)
        @quality += 2
      elsif @sell_in > 10 && @quality <= (QUALITY_CAP - 1)
        @quality += 1
      else
        @quality = QUALITY_CAP
      end
    end

    def conjured
      if @sell_in >= 0 && @quality > (QUALITY_FLOOR + 1)
        @quality -= 2
      elsif @sell_in < 0 && @quality > (QUALITY_FLOOR + 3)
        @quality -= 4
      else
        @quality = QUALITY_FLOOR
     end
    end

    def standard
      if @sell_in < 0 &&  @quality > (QUALITY_FLOOR + 2)
        @quality -= 2
      elsif @sell_in >= 0 &&  @quality > (QUALITY_FLOOR + 1)
        @quality -= 1
      else
        @quality = QUALITY_FLOOR
      end
    end

    def sell_in_reduce
      @name == @specials[2] ? @sell_in : @sell_in -= 1
    end

end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
