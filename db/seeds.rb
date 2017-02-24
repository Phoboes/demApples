# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
#
u1 = User.create( {
  name: 'Kane',
  email: 'admin@apple.com',
  password: 'chicken',
  password_confirmation: 'chicken',
  admin: true
 } )

u2 = User.create( {
  name: 'John',
  email: 'john@apple.com',
  password: 'chicken',
  password_confirmation: 'chicken',
  admin: false
 } )

 u3 = User.create( {
   name: 'Sarah',
   email: 'Sarah@apple.com',
   password: 'chicken',
   password_confirmation: 'chicken',
   admin: false
  } )

#--------------------------------------------------------------------

Cart.destroy_all

c1 = Cart.create( {
  user_id: u1.id,
  purchase_completed: true
  } )

c2 = Cart.create( {
  user_id: u1.id,
  purchase_completed: true
  } )

c3 = Cart.create( {
  user_id: u1.id,
  purchase_completed: false
  } )

  #--------------------------------------------------------------------

Category.destroy_all

c1 = Category.new( { name: "fruit" } )
c2 = Category.new( { name: "political" } )

  #--------------------------------------------------------------------

# Product.destroy_all

  p1 = Product.create({
    name: "Granny Smith",
    price: 4.80,
    description: "I don't know who Granny Smith is, or why she thinks she owns so many bloody apples, but she can't have them all. Grab a piece of the action. You hear that, Granny? How you like them apples? Huh?"
  })

  p1.categories << c1

  p2 = Product.create({
    name: "Redlove apples",
    price: 2.99,
    description: "Ever wanted an apple that bleeds? We've got you covered. The redlove apple has red flesh and chronic attachment issues."
  })

  p2.categories << c1

  p3 = Product.create({
    name: "Crab apples",
    price: 2.20,
    description: "While they may sound like something you could pick up from a seedy public toilet, they're actually tiny sour apples. No crustaceans or manky public spaces required."
  })

p3.categories << c1

  p4 = Product.create({
    name: "Adam's apple",
    price: 79.99,
    description: "Organically grown and hormone(ish) free. The extended gestation period for these apples (nearly 16 years in some cases) makes them a hot commodity. \n Talking serpents sold separately."
  })

  p5 = Product.create({
    name: "Communist apples",
    price: 10.00,
    description: "Make a statement about your political standings. Promote the Che's ideals with senseless purchases (why not get 2? Or 7?). Seriously though, these are <strong>killer</strong> apples."
  })

  #--------------------------------------------------------------------

  # ProductImage.destroy_all

  i1 = ProductImage.create({
    product_id: p1.id,
    public_id: "gotApples/null",
    image_url: "apple_seeds/granny.jpg",
    attr_desc: "A Granny Smith apple."
  })

  i2 = ProductImage.create({
    product_id: p2.id,
    public_id: "gotApples/null",
    image_url: "apple_seeds/100721_apple1.jpg",
    attr_desc: "A Redlove apple."
  })

  i3 = ProductImage.create({
    product_id: p3.id,
    public_id: "gotApples/null",
    image_url: "apple_seeds/crab-apple-tree-pruning.jpg",
    attr_desc: "A crab apple."
  })

  i4 = ProductImage.create({
    product_id: p4.id,
    public_id: "gotApples/null",
    image_url: "apple_seeds/adams-apple-dr-barry-eppley-indianapolis.jpg",
    attr_desc: "An Adam's apple."
  })

  i5 = ProductImage.create({
    product_id: p5.id,
    public_id: "gotApples/null",
    image_url: "apple_seeds/Che-460.jpg",
    attr_desc: "A communist apple."
  })

p5.categories << c1 << c2

#--------------------------------------------------------------------

Cart.destroy_all

c1 = Cart.create({ user_id: u1.id, purchase_completed: false })

#--------------------------------------------------------------------

CartItem.destroy_all

ci1 = CartItem.create({ product_id: p1.id, cart_id: c1.id, quantity: 1 })
ci2 = CartItem.create({ product_id: p2.id, cart_id: c1.id, quantity: 2 })
ci3 = CartItem.create({ product_id: p3.id, cart_id: c1.id, quantity: 5 })

