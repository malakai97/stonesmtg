class CardName
  def initialize(string)
    @name = string
  end

  attr_reader :name

  def to_s
    name
  end

  def url_safe
    name.downcase.gsub("'", '').split(' ').join('+')
  end
end

