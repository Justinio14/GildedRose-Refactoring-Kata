
## Gilded Rose

### Basic system requirements
- All items have a SellIn value which denotes the number of days we have to sell the item
- All items have a Quality value which denotes how valuable the item is
- At the end of each day our system lowers both values for every item

### Specific requirements

- Once the sell by date has passed, Quality degrades twice as fast
- The Quality of an item is never negative
- "Aged Brie" actually increases in Quality the older it gets
- The Quality of an item is never more than 50
- "Sulfuras", being a legendary item, never has to be sold or decreases in Quality
- "Backstage passes", like aged brie, increases in Quality as its SellIn value approaches;
	Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but
	Quality drops to 0 after the concert

### Diagram overview

![alt text] (https://github.com/Justinio14/GildedRose-Refactoring-Kata/tree/master/ruby/images/gilded_rose.png)

### Instructions

- make a new directory
- clone git repo https://github.com/Justinio14/GildedRose-Refactoring-Kata
- Open repel in terminal (irb /pry)
	- require "./gilded_rose"
	- create a new Item instance
		- item = Item.new("Backstage passes to a TAFKAL80ETC concert", 3, 60)
	- create a new GildedRose instance
	 	- rose = GildedRose.new(item) 
	- call rose.update_quality
	- call rose.sell_in / rose.name / rose.quality to view item values
