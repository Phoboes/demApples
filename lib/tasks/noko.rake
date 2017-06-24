namespace :noko do
  require 'open-uri'
  require 'pry'
  desc "Strips a collection of apples from a fruit enthusiast site. Sorry, guy."
  task apple_seeds: :environment do
    timer_start = Time.now
    base_url = "https://www.orangepippin.com/"

  p '---------------------------------------------------'

    # kill all old apples from previous rake tasks
    previously_scraped_products = Product.joins(:categories).where(categories: {name: "scraped"}) 
    p "Currently deleting " + previously_scraped_products.count.to_s + " old records. Stand by."
    previously_scraped_products.destroy_all

    # Kill our old scraped categories.
    Category.where( name: "scraped" ).destroy_all

    # Make a new one for appending (and the fruit category for searching)
    scraped = Category.create( name: "scraped" )
    fruit = Category.where( name: "fruit")

    p '---------------------------------------------------'
    p "Previous records destroyed. Starting scrape of " + base_url + "."

    # Hit all indexes on target website (sorted alphabetically)
    ("A".."Z").each do |letter|
      index = Nokogiri::HTML( open( base_url + "apples/" + letter ) ) #each letter page on our base_url
      # all the lis (or items in this case) on the page.
      pages = index.css("#catalogue li")

      pages.each_with_index do | list_content, index |
        if list_content.css('img').present?
        page_url = list_content.css("h3 a")[0]["href"]
        page = Nokogiri::HTML( open( page_url ) )

        # Checks if there is an image on the page, and verifies we haven't already got this apple.
        if page.css(".photopaper img").present? && Product.find_by(name: page.css(".varietyname_title").text).nil?
          img_url = page.css(".photopaper img").attr("src").value
          img_url.slice!(0,3) #strike useless characters from the start of img url: '../' in this case.
          img_url = base_url + img_url # full url to image

          # The public ID is how cloudinary targets an item for modification.
            # Seeing as I may have multiple images on a product, Ideally I want the syntax to be something like p.id/image.id

          cloudinary = Cloudinary::Uploader.upload( img_url,
            :public_id => "apples/" + ( Product.last.id + 1 ).to_s + "/" + ( ProductImage.last.id + 1 ).to_s
          )

          image = ProductImage.new({
            public_id: cloudinary['public_id'],
            image_url: cloudinary['url'],
            attr_desc: "A picture of a " + page.css(".varietyname_title").text + " apple."
          })


        product = Product.create({
            name: page.css(".varietyname_title").text.gsub(/[®]/, ''),
            price: rand(0.1..8.0).round(2),
            description: page.css(".variety_subtitle").text
        })
          image.product_id = product.id
          image.save
          # Tie our image/s and product together.
          product.product_images << image
          # Provide our categories created above.
          product.categories << scraped
          product.categories << fruit

          p '---------------------------------------------------'
          p "Name:" + product.name
          p "Cloudinary URL: " + image.image_url
          p "Randomly generated price: " + product.price.to_s
          p "Assigned category: " + product.categories.name
          p "Time elapsed: " + (Time.now - timer_start).round(0).to_s + " seconds."

          end
        end
      end
    end
    p
    p '---------------------------------------------------'
    p '----------------------COMPLETE---------------------'
    p '---------------------------------------------------'
    p "Rake task complete, time taken: " + ( (Time.now - timer_start ) / 60 ).round(1).to_s + " minutes."
    p Product.joins(:categories).where(categories: {name: "scraped"}).count.to_s + " products scraped."
  end
end
