# Seed visitors
visitors = []
1000.times do
  days_ago = rand(0..30)
  visitors << { name: Faker::Name.name, created_at: days_ago.days.ago }
end

Visitor.insert_all(visitors)

# Seed Items
Item.find_or_create_by(product: 'Phone', cost: 550)
Item.find_or_create_by(product: 'Laptop', cost: 1100)
Item.find_or_create_by(product: 'TV', cost: 400)
Item.find_or_create_by(product: 'Headphones', cost: 100)

# Seed sales
sales = []
items = Item.all
1500.times do
  days_ago = rand(0..30)
  item = items.sample
  sales << { visitor_id: Visitor.order("RANDOM()").first.id, item_id: item.id, revenue: item.cost, profit: (item.cost * 0.3).round, created_at: days_ago.days.ago }
end

Sale.insert_all(sales)
