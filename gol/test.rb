require 'curses'
require './gol.rb'
require 'pry'

Curses.init_screen()
width = Curses.cols
height = Curses.lines

world = World.new(width, height)

win = Curses::Window.new(0, 0, 0, 0)

run = true
win.clear
win.box("|", "-")
win.bkgd(" ")

while run do
  world.cells.each do |cell|
    win.setpos(cell.location.y + 1, cell.location.x + 1)
    win.delch()
    win.insch("0")
  end
  world.tick
  world.update_world
  win.refresh
  
  #sleep(1)
end



win.getch
win.close

