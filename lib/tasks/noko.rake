namespace :noko do
  # OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
  # require 'open-uri'
  desc "Collects apples from the internet"
  task apples: :environment do

    base_url = "https://www.orangepippin.com/apples/"


    # kill all old apples from previous rake tasks

    Product.joins(:categories).where(categories: {name: "scraped"}).destroy_all

    # Kill our old scraped categories.
    Category.where( name: "scraped" ).destroy_all

    # Make a new one for appending (and the fruit category for searching)
    scraped = Category.create( name: "scraped" )
    fruit = Category.where( name: "fruit")


    # Hit all indexes on site (sorted alphabetically)
    ("A".."Z").each do |letter|
      letter = "a"
      index = Nokogiri::HTML( open( base_url + letter ) ) #each letter page on our base_url
      # all the lis (or items in this case) on the page.
      pages = index.css("#catalogue li")

      pages.each do | list_content |

        page_url = list_content.css(".catalogue_inner h3 a")["href"]

        page = Nokogiri::HTML( open( page_url ) )
        product = Product.create({
          name: page.css(".varietyname_title").text
          # If a link is present, provide it, or provide the string "default"
          image_url: page.css(".photopaper img").attr("src").present? ? page.css(".photopaper img").attr("src") : "default"
          description: page.css(".variety_subtitle").text
          })

          # Provide our categories created above.
          product.categories << scraped
          product.categories << fruit

          p product.name
          p product.image_url
          p product.categories
      end
    end
  end
end
