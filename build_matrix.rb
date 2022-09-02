

class BuildMatrix
  require_relative 'playing_cards'
  attr_accessor :hand, :solution
  require 'pry'

  @hand
  @solution

  def show_cards(list_of_cards)
    list_of_cards.each_with_index do |c, i |
        print "#{c.value}#{c.suit} | "
        print "\n" if (i+1).modulo(4) == 0
    end
  end

  def show_list(list)
    list.each do |tetrad|
      tetrad.each do |card|
        print "#{card} | "
      end
      print "\n"
    end
  end

  def initialize
    pc = PlayingCards.new
    pc.shuffle
    @hand = pc.cards
    @solution = reorg
  end

  def answer
    puts "===Original Hand==="
    show_cards(@hand)
    puts ""
    puts "=Reordered Matrix=="
    show_list(@solution)
  end

  private

  def reorg
    l1 = split_tetrad(get_base_tetrad.flatten)
    l2 = flip_and_swap_row(l1)
    l3 = swap_and_reverse_row([l1[0],l2[1]])
    l4 = flip_and_swap_row(l3)
    @solution = [join(l1), join(l2), join(l3), join(l4)]
  end


  def flip_and_swap_row(list)
    tetrad = [swap_halves(list[0])]
    tetrad << flip_and_swap(list[1])
    tetrad
  end

  def swap_and_reverse_row(list)
    tetrad = [reverse(list[0])]
    tetrad << swap_halves(list[1])
    tetrad
  end

  def swap_halves(seg)
    mid = seg.count/2
    new_seg = seg.dup.slice(mid..seg.count)
    new_seg << seg.dup.slice(0..mid-1)
    new_seg.flatten!
  end

  def reverse(list)
    new_list = list.clone
    mid = new_list.count/2
    mid.times {|i| new_list[i], new_list[-i-1] = new_list[-i-1], new_list[i] }
    new_list
  end

  def flip_and_swap(list)
    mid = list.count/2
    first_half = list.dup.slice(mid..list.count)
    first_half = reverse(first_half)
    second_half = list.dup.slice(0..mid-1)
    second_half = reverse(second_half)
    first_half + second_half
  end

  def join(list)
    row = []
    (0..3).each do |i|
      card = "#{list[0][i]}#{list[1][i]}"
      row << card
    end
    row
  end

  def card_in_tetrad?(seg, card)
    found = false
    seg.each do |seg_card|
      found = seg_card.value == card.value || seg_card.suit == card.suit
      break if found
    end
    found
  end

  def split_tetrad(tetrad)
    v = []
    s = []
    tetrad.each do |c|
      v << c.value
      s << c.suit
    end
    [v,s]
  end

  def get_base_tetrad
    seg = []
    seg << @hand.first

    @hand.each_with_index  do |card, idx|
      if !card_in_tetrad?(seg, card)
        seg << card
      end
      break if seg.count == 4
    end
    seg
  end
end