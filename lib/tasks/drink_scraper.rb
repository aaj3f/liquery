class DrinkScraper

  BASE_URL = "https://en.wikipedia.org"

  def wikipedia_scraper(creation_hash, wiki_url)
    doc = Nokogiri::HTML(open(wiki_url))

    url_array = doc.css("div.div-col.columns.column-width li a").each.with_object([]) do |node, array|
      array << node['href']
    end

    url_array.each.with_object(creation_hash) do |url, hash|
      doc = Nokogiri::HTML(open(BASE_URL + url))
      inner_doc = doc.css("table.infobox tbody")

      binding.pry

      #name = doc.css("table.infobox caption").first.children.text
      #image = doc.css("a.image img").select {|node| node.attributes['width'].value.to_i > 100}.first
      #primary_alochols (array)= inner_doc.css("tr").find {|node| node.css("th").text.match?("Primary alcohol") }.css("li a").map {|node| node.text}
      #ingredients (array)= inner_doc.css("tr").find {|node| node.css("th").text.match?("IBA specified") }.css("td ul li").map {|node| node.text}
      #preparation (string)= inner_doc.css("tr").find {|node| node.css("th").text.match?("Preparation") }.css("td").first.text
    end

  end
end
