require "gosu"

#  must install gosu gem to use class
class Drawer < Gosu::Window
  def initialize(user_obj, max_x: 800, max_y: 600, cellsize: 4, bkground_color: 0x00000000, foreground_color: 0xFFFFFFFF)
    # parameters
    @window_x = max_x;
    @window_y = max_y;
    #@bkgrnd_color = bkground_color;
    @color = foreground_color
    @user_obj = user_obj

    @cellsize = cellsize

    super(@window_x, @window_y, false)
  end

  def button_down(id)
    case id
    when Gosu::Button::KbEscape
      close
    end
  end

  def draw_point(x, y)
    left = (x * @cellsize)+1
    top = (y * @cellsize)+1
    right = (x * @cellsize + @cellsize)-1
    bottom = (y * @cellsize + @cellsize)-1

    self.draw_line(left, top, @color, right, top, @color)
    self.draw_line(right, top, @color, right, bottom, @color)
    self.draw_line(right, bottom, @color, left, bottom, @color)
    self.draw_line(left, bottom, @color, left, top, @color)
  end

  def draw
    @user_obj.draw
  end

  def update
    if @user_obj.respond_to?(:update)
      @user_obj.update
    end
  end
end


# example code below to demostrate how to utilize the class to render the GOL output to screen
#class MyCode
#  def initialize
#    @drawer = Drawer.new(self)
#    @drawer.show
#  end
#
#  def draw
#    (0..1000).each do |x|
#      @drawer.draw_point(x, 6)
#      @drawer.draw_point(x, 1)
#    end
#  end
#end
#
#mycode = MyCode.new








