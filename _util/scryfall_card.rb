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

  def json
    `curl -s -X GET 'https://api.scryfall.com/cards/named?set=mh1&exact=#{name.url_safe}'`.strip
  end

  def card_obj
    @card_obj ||= JSON.parse(json)
  end
end


