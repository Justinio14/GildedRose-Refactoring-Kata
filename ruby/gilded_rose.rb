class GildedRose

  attr_reader :name, :sell_in, :quality

  QUALITY_FLOOR = 0
  QUALITY_CAP = 50
  SULFURAS_QUALITY = 80

  def initialize(items)
    @items = items
    @name = ""
    @quality = 0
    @sell_in = 0
  end

  def item_display()
    @items.each do |item|
      @name = item.name
      @sell_in = item.sell_in
      @quality = item.quality
    end
    quality_limit
  end

  def update_quality()
    item_display
    sell_in_reduce
    item_selection
  end

  private

  def quality_limit
    @quality > QUALITY_CAP ? @quality = QUALITY_CAP : @quality = @quality
  end

  def sell_in_reduce
    @name == "Sulfuras, Hand of Ragnaros" ? @sell_in : @sell_in -= 1
  end

  def item_selection
    if @name == "Aged Brie"
      aged_brie
    elsif @name == "Backstage passes to a TAFKAL80ETC concert"
      backstage
    elsif @name == "Sulfuras, Hand of Ragnaros"
      sulfuras
    elsif @name == "Conjured"
      conjured
    else
      standard
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
    elsif @sell_in < 6 && @quality < (QUALITY_CAP - 2)
      @quality += 3
    elsif @sell_in < 11 && @quality < (QUALITY_CAP - 1)
      @quality += 2
    elsif @sell_in > 10 && @quality < QUALITY_CAP
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
    if @sell_in < 0 && @quality > (QUALITY_FLOOR + 1)
      @quality -= 2
    elsif @sell_in >= 0 && @quality > QUALITY_FLOOR
      @quality -= 1
    else
      @quality = QUALITY_FLOOR
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
