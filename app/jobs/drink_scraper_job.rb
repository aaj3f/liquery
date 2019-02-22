class DrinkScraperJob

  BASE_URL = "https://en.wikipedia.org"
  DEFAULT_COCKTAIL_URL = "https://d1nhio0ox7pgb.cloudfront.net/_img/o_collection_png/green_dark_grey/256x256/plain/cocktail.png"

  def initialize
    x = self.wikipedia_scraper({}, "https://en.wikipedia.org/wiki/List_of_IBA_official_cocktails")
    binding.pry
  end

  def wikipedia_scraper(creation_hash, wiki_url)
    doc = Nokogiri::HTML(open(wiki_url))

    url_array = doc.css("div.div-col.columns.column-width li a").each.with_object([]) do |node, array|
      array << node['href']
    end

    url_array.each.with_object(creation_hash) do |url, hash|
      doc = Nokogiri::HTML(open(BASE_URL + url))
      inner_doc = doc.css("table.infobox tbody")

      if doc.css("table.infobox").size > 1

        doc.css("table.infobox").select {|node| node.text.match?("IBA official") }.each.with_index do |node, index|
          name = node.css("caption").children.text
          hash[name] ||= {
            'image' => "https:" + (node.css("a.image img").select {|inner_node| inner_node.attributes['width'].value.to_i > 100}.first&.attributes&.[]('src')&.value || doc.css("a.image img").select {|node| node.attributes['width'].value.to_i > 100}.first&.attributes&.[]('src')&.value || DEFAULT_COCKTAIL_URL),
            'primary_alcohols' => node.css("tr").find {|node| node.css("th").text.match?("Primary alcohol") }.css("li a").map {|node| node.text},
            'ingredients' => node.css("tr").find {|inner_node| inner_node.css("th").text.match?("IBA specified") }.css("td ul li").map {|inner_node| inner_node.text},
            'preparation' => node.css("tr").find {|inner_node| inner_node.css("th").text.match?("Preparation") }.css("td").first.text
          }
          puts hash.keys.last
          # hash['image'] = "https:" + (node.css("a.image img").select {|inner_node| inner_node.attributes['width'].value.to_i > 100}.first&.attributes&.[]('src')&.value || doc.css("a.image img").select {|node| node.attributes['width'].value.to_i > 100}.first.attributes['src'].value)
          # hash['primary_alochols'] (array)= node.css("tr").find {|node| node.css("th").text.match?("Primary alcohol") }.css("li a").map {|node| node.text}
          # hash['ingredients'] (array)= node.css("tr").find {|inner_node| inner_node.css("th").text.match?("IBA specified") }.css("td ul li").map {|inner_node| inner_node.text}
          # hash['preparation'] (string)= node.css("tr").find {|inner_node| inner_node.css("th").text.match?("Preparation") }.css("td").first.text

        end

      else
        name = doc.css("table.infobox caption").first.children.text
        # binding.pry unless doc.css("a.image img").select {|node| node.attributes['width'].value.to_i > 100}.first&.attributes&.[]('src')&.value
        hash[name] ||= {
          'image' => "https:" + (doc.css("a.image img").select {|node| node.attributes['width'].value.to_i > 100}.first&.attributes&.[]('src')&.value || DEFAULT_COCKTAIL_URL),
          'primary_alcohols' => inner_doc.css("tr").find {|node| node.css("th").text.match?("Primary alcohol") }.css("li a").map {|node| node.text},
          'ingredients' => inner_doc.css("tr").find {|node| node.css("th").text.match?("IBA") }.css("td ul li").map {|node| node.text},
          'preparation' => inner_doc.css("tr").find {|node| node.css("th").text.match?("Preparation") }.css("td").first.text
        } unless name.match?("colada")
        puts hash.keys.last
      end


      #name = doc.css("table.infobox caption").first.children.text
      #image = "https:" + doc.css("a.image img").select {|node| node.attributes['width'].value.to_i > 100}.first.attributes['src'].value
      #primary_alochols (array)= inner_doc.css("tr").find {|node| node.css("th").text.match?("Primary alcohol") }.css("li a").map {|node| node.text}
      #ingredients (array)= inner_doc.css("tr").find {|node| node.css("th").text.match?("IBA specified") }.css("td ul li").map {|node| node.text}
      #preparation (string)= inner_doc.css("tr").find {|node| node.css("th").text.match?("Preparation") }.css("td").first.text

    end

  end

end
