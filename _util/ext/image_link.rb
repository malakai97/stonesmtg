require_relative "card_name"
require_relative "scryfall_card"

module Kernel
  def image_link(name)
    ScryfallCard.new(CardName.new(name)).image_link
  end
end


