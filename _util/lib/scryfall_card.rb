require "json"

class ScryfallCard
  def initialize(name)
    @name = name
  end

  def image_link
    card_obj
      .fetch("image_uris", {})
      .fetch("small", "NOT FOUND")
  end

  private

  attr_reader :name

  def set
    "mh1" # Modern Horizons
  end

  def json
    `curl -s -X GET 'https://api.scryfall.com/cards/named?set=#{set}&exact=#{name.url_safe}'`.strip
  end

  def card_obj
    @card_obj ||= JSON.parse(json)
  end
end


