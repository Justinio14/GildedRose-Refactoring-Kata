class GildedRose

  def initialize(items)
    @items = items

  end

  QUALITY_FLOOR = 0
  QUALITY_CAP = 50
  SULFURAS_QUALITY = 80
  @specials = ["Aged Brie", "Backstage passes to a TAFKAL80ETC concert", "Sulfuras, Hand of Ragnaros" ]

  def item_display()
    @items.each do |item|
      @name = item.name
      @quality = item.quality
      @sell_in = item.sell_in
    end
  end

  def aged_brie
    @quality < QUALITY_CAP  ? @quality += 1 : @quality = QUALITY_CAP
  end

  def sulfuras
    @quality = SULFURAS_QUALITY
  end

  def backstage
    if @sell_in < 0
      @quality = QUALITY_FLOOR
    elsif @sell_in < 6 && @quality < (QUALITY_CAP - 3)
      @quality += 3
    elsif @sell_in < 11 && @quality < (QUALITY_CAP - 2)
      @quality += 2
    elsif @sell_in > 10 && @quality < (QUALITY_CAP - 1)
      @quality += 1
    else
      @quality = QUALITY_CAP
    end
  end

  def standard
    @sell_in > 0 ? @quality -= 1 : @quality -= 2
  end

  def sell_reduce
    @sell_in -= 1
  end

  def update_quality()
    if @specials.exclude? @name
      standard
    elsif @specials[0] == @name
      aged_brie
    elsif @specials[1] == @name
      backstage
    else
      sulfuras
    end
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
