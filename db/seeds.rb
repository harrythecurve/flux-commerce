# Seed visitors
visitors = []
points = []
10000.times do
  days_ago = rand(0..30)
  name = Faker::Name.name
  visitors << { name: name, created_at: days_ago.days.ago }
  point = InfluxDB2::Point.new(name: "visitors")
                          .time(days_ago.days.ago, InfluxDB2::WritePrecision::NANOSECOND)
                          .add_field('name', name)
  points << point
end

Visitor.insert_all(visitors)
INFLUX_WRITE_API.write(data: points)

# Seed Items
Item.find_or_create_by(product: 'Phone', cost: 550)
Item.find_or_create_by(product: 'Laptop', cost: 1100)
Item.find_or_create_by(product: 'TV', cost: 400)
Item.find_or_create_by(product: 'Headphones', cost: 100)

# Seed sales
sales = []
points = []
items = Item.all
15000.times do
  days_ago = rand(0..30)
  item = items.sample
  visitor_id = Visitor.order("RANDOM()").first.id
  sales << { visitor_id: visitor_id, item_id: item.id, revenue: item.cost, profit: (item.cost * 0.3).round, created_at: days_ago.days.ago }
  point = InfluxDB2::Point.new(name: "sales")
                          .time(days_ago.days.ago, InfluxDB2::WritePrecision::NANOSECOND)
                          .add_tag('visitor_id', visitor_id)
                          .add_tag('item_id', item.id)
                          .add_field('revenue', item.cost)
                          .add_field('profit', (item.cost * 0.3).round)
  points << point
end

Sale.insert_all(sales)
INFLUX_WRITE_API.write(data: points)
