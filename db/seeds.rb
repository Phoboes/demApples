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

Product.destroy_all

  p1 = Product.create({
    name: "Granny Smith",
    price: 4.80,
    image_url: "http://scene7.samsclub.com/is/image/samsclub/0003338300159_A?$img_size_380x380$",
    description: "I don't know who Granny Smith is, or why she thinks she owns so many bloody apples, but she can't have them all. Grab a piece of the action. You hear that, Granny? How you like them apples? Huh?"
  })

  p1.categories << c1

  p2 = Product.create({
    name: "Redlove apples",
    price: 2.99,
    image_url: "http://newsliteimgs.s3.amazonaws.com/100721_apple1.jpg",
    description: "Ever wanted an apple that bleeds? We've got you covered. The redlove apple has red flesh and chronic attachment issues."
  })

  p2.categories << c1

  p3 = Product.create({
    name: "Crab apples",
    price: 2.20,
    image_url: "http://www.sophisticatedgardening.com/wp-content/uploads/2012/08/crab-apple-tree-pruning.jpg",
    description: "While they may sound like something you could pick up from a seedy public toilet, they're actually tiny sour apples. No crustaceans or manky public spaces required."
  })

p3.categories << c1

  p4 = Product.create({
    name: "Adam's apple",
    price: 79.99,
    image_url: "http://exploreplasticsurgery.com/wp-content/uploads/2011/08/adams-apple-dr-barry-eppley-indianapolis.jpg",
    description: "Organically grown and hormone(ish) free. The extended gestation period for these apples (nearly 16 years in some cases) makes them a hot commodity. \n Talking serpents sold separately."
  })

  p5 = Product.create({
    name: "Communist apples",
    price: 10.00,
    image_url: "http://www.ediblegeography.com/wp-content/uploads/2013/02/Che-460.jpg",
    description: "Make a statement about your political standings. Promote the Che's ideals with senseless purchases (why not get 2? Or 7?). Seriously though, these are <strong>killer</strong> apples."
  })

p5.categories << c1 << c2
