require './gol.rb'
require './drawer.rb'

require 'pry'


class Game 
 def initialize
   @world = World.new
   
   @drawer = Drawer.new(self)
   @drawer.show
 end

  
  def draw
    @world.cells.each do |cell|
      @drawer.draw_point(cell.location.x.to_i, cell.location.y.to_i)
    end
  end
 
 def play
   # it never gets here - is stuck in the @drawer.show in the game initializer from what i can see so far...
   binding.pry
   
   
   while true
     @world.tick     
   end
 end
 
end

game = Game.new

game.play