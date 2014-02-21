require './gol.rb'
require './drawer.rb'

require 'pry'


class Game 
 def initialize
   @world = World.new
   
   @drawer = Drawer.new(@world)
   @drawer.show
 end

 
 def play
   
   binding.pry
   
   
   while true
     @world.tick     
   end
 end
 
end

game = Game.new

game.play