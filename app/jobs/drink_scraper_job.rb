class DrinkScraperJob

  BASE_URL = "https://en.wikipedia.org"

  def initialize
    self.wikipedia_scraper({}, "https://en.wikipedia.org/wiki/List_of_IBA_official_cocktails")
  end

  def wikipedia_scraper(creation_hash, wiki_url)
    doc = Nokogiri::HTML(open(wiki_url))

    url_array = doc.css("div.div-col.columns.column-width li a").each.with_object([]) do |node, array|
      array << node['href']
    end

    url_array.each.with_object(creation_hash) do |url, hash|
      doc = Nokogiri::HTML(open(BASE_URL + url))
      inner_doc = doc.css("table.infobox tbody")

      if doc.css("table.infobox caption").size > 1

        doc.css("table.infobox caption").each do |node|
          #isolate each table as inner_doc and supply info for each
        end

      else
        #provide normal drink attributes as drafted below
      end

      binding.pry if (doc.css("table.infobox caption").first.children.text == "Fizz")

      #name = doc.css("table.infobox caption").first.children.text
      #image = "https:" + doc.css("a.image img").select {|node| node.attributes['width'].value.to_i > 100}.first.attributes['src'].value
      #primary_alochols (array)= inner_doc.css("tr").find {|node| node.css("th").text.match?("Primary alcohol") }.css("li a").map {|node| node.text}
      #ingredients (array)= inner_doc.css("tr").find {|node| node.css("th").text.match?("IBA specified") }.css("td ul li").map {|node| node.text}
      #preparation (string)= inner_doc.css("tr").find {|node| node.css("th").text.match?("Preparation") }.css("td").first.text
    end

  end

end
