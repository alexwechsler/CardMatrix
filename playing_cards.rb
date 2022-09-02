class PlayingCards
  require_relative 'card'
  attr_accessor :cards

  @cards

  def shuffle
    @cards.length.times do
      random_idx = rand(@cards.length)
      random_card = @cards[random_idx]
      @cards << random_card
      @cards.delete_at(random_idx)
    end
  end

  def initialize
    cards = []
    ["K","Q","J","A"].each do |v|
      ♠ = Card.new(v,"♠")
      ♥ = Card.new(v,"♥")
      ♣ = Card.new(v,"♣")
      ♦ = Card.new(v,"♦")
      cards << [♠,♥,♣,♦]
      cards.flatten!
    end
    @cards = cards
  end
end