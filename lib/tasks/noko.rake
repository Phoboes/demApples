namespace :noko do
  # OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
  # Bypass for my windows environment.
  require 'open-uri'
  desc "Strips a collection of apples from a fruit enthusiast site. Sorry, guy."
  task apples: :environment do

    base_url = "https://www.orangepippin.com/"


    # kill all old apples from previous rake tasks

    Product.joins(:categories).where(categories: {name: "scraped"}).destroy_all

    # Kill our old scraped categories.
    Category.where( name: "scraped" ).destroy_all

    # Make a new one for appending (and the fruit category for searching)
    scraped = Category.create( name: "scraped" )
    fruit = Category.where( name: "fruit")

    # Hit all indexes on site (sorted alphabetically)
    ("A".."Z").each do |letter|
      index = Nokogiri::HTML( open( base_url + "apples/" + letter ) ) #each letter page on our base_url
      # all the lis (or items in this case) on the page.
      pages = index.css("#catalogue li")

      pages.each_with_index do | list_content, index |
        if list_content.css('img').present?

        page_url = list_content.css("h3 a")[0]["href"]


        page = Nokogiri::HTML( open( page_url ) )

        if page.css(".photopaper img").present?


          img_url = page.css(".photopaper img").attr("src").value
          img_url.slice!(0,3) #strike useless characters from the start of img url: '../' in this case.

          img_url = base_url + img_url


          cloudinary = Cloudinary::Uploader.upload( img_url, :public_id => "apples/" + index )

        else
          img_url = "default"
        end


        product = Product.create({
            name: page.css(".varietyname_title").text,
            image_url: cloudinary["url"],
            price: rand(0.1..8.0).round(2),
            description: page.css(".variety_subtitle").text
          })

          # Provide our categories created above.
          product.categories << scraped
          product.categories << fruit


          p '---------------------------------------------------'
          p product.name
          p product.image_url
          p product.price
          p product.categories
          p '---------------------------------------------------'
          
        end
      end
    end
  end
end
