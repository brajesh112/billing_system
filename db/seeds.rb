puts "Seeding products..."

products = [
  {
    name: "Pen",
    product_code: "PEN001",
    stock: 100,
    unit_price: 10.00,
    tax_percentage: 5.0
  },
  {
    name: "Notebook",
    product_code: "NOTE001",
    stock: 50,
    unit_price: 50.00,
    tax_percentage: 12.0
  },
  {
    name: "Pencil",
    product_code: "PENCL001",
    stock: 200,
    unit_price: 5.00,
    tax_percentage: 5.0
  }
]

products.each do |attrs|
  Product.find_or_create_by!(product_code: attrs[:product_code]) do |product|
    product.assign_attributes(attrs)
  end
end

puts "Products seeded safely"

puts "Seeding denominations..."

[2000, 500, 200, 100, 50, 20, 10, 5, 2, 1].each do |value|
  Denomination.find_or_create_by!(value: value) do |d|
    d.available_count = 50
  end
end

puts "Denominations seeded safely"
