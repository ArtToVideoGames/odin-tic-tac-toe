module Detect
  def barRun(char, value, nextValue, finalValue)
    if(value == char and nextValue == char and finalValue == char)
      return true
    else
      return false
    end
  end
end

module Board
  def boardLayout(hash)
    return("\n  #{hash[:one]} | #{hash[:two]} | #{hash[:three]} \n ---+---+--- \n  #{hash[:four]} | #{hash[:five]} | #{hash[:six]} \n ---+---+--- \n  #{hash[:seven]} | #{hash[:eight]} | #{hash[:nine]}")
  end
end

class BoardDisplay
  include Board
  def initialize(hash)
    puts boardLayout(hash)
  end
end

class Player
  def initialize(pName, pChar, pValue)
    @playerName = pName
    @playerCharacter = pChar
    @playerValue = pValue
  end

  def name()
    return @playerName
  end

  def char()
    return @playerCharacter
  end

  def value()
    return @playerValue
  end
end

puts "Player 1, please input your name"
player1Name = gets.chomp()

puts "Player 1, please input your game character"
player1Value = gets.chomp()

puts "Player 2, please input your name"
player2Name = gets.chomp()

puts "Player 2, please input your game character"
player2Value = gets.chomp()

player1 = Player.new(player1Name, player1Value, 1)
player2 = Player.new(player2Name, player2Value, 2)

valueHash = Hash.new()

valueHash[:one] = "1"
valueHash[:two] = "2"
valueHash[:three] = "3"
valueHash[:four] = "4"
valueHash[:five] = "5"
valueHash[:six] = "6"
valueHash[:seven] = "7"
valueHash[:eight] = "8"
valueHash[:nine] = "9"

board = BoardDisplay.new(valueHash)

class GameManager
  include Detect
  
  def play(player, other_player, hash)
    valueHash = hash
    puts "\n#{player.name()} please choose a number (1-9) to place your #{player.char()}"

    value = gets.chomp()
    value = value.to_i
    unless(valueHash.values[value - 1] == player.char() or   valueHash.values[value - 1] == other_player.char())
      if(value == 1)
        valueHash[:one] = player.char()
      elsif(value == 2)
        valueHash[:two] = player.char()
      elsif(value == 3)
        valueHash[:three] = player.char()
      elsif(value == 4)
        valueHash[:four] = player.char()
      elsif(value == 5)
        valueHash[:five] = player.char()
      elsif(value == 6)
        valueHash[:six] = player.char()
      elsif(value == 7)
        valueHash[:seven] = player.char()
      elsif(value == 8)
        valueHash[:eight] = player.char()
      elsif(value == 9)
        valueHash[:nine] = player.char()
    end

      board = BoardDisplay.new(valueHash)
      if(detect(player, valueHash) == true)
        puts "\n#{player.name()} has won the game!"
      else
        play(other_player, player, valueHash)
      end
    else
      play(player, other_player, valueHash)
    end
  end

  def detect(player, hash)

    char = player.char()
    v1 = hash[:one]
    v2 = hash[:two]
    v3 = hash[:three]
    v4 = hash[:four]
    v5 = hash[:five]
    v6 = hash[:six]
    v7 = hash[:seven]
    v8 = hash[:eight]
    v9 = hash[:nine]
    
    hash.each do |key, value|
      if(key == :one)
        if(barRun(char, v1, v2, v3) == true)
          return true
          break
        elsif(barRun(char, v1, v5, v9) == true)
          return true
          break
        elsif(barRun(char, v1, v4, v7) == true)
          return true
          break
        end
      elsif(key == :two)
        if(barRun(char, v2, v5, v8) == true)
          return true
          break
        end
      elsif(key == :three)
        if(barRun(char, v3, v6, v9) == true)
          return true
          break
        elsif(barRun(char, v3, v5, v7) == true)
          return true
          break
        end
      elsif(key == :four)
        if(barRun(char, v4, v5, v6) == true)
          return true
          break
        end
      elsif(key == :seven)
        if(barRun(char, v7, v8, v9) == true)
          return true
          break
        end
      end
    end
  end
end

game = GameManager.new()
game.play(player1, player2, valueHash)