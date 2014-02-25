
class Point
  attr_accessor :x, :y
  
  def initialize(x,y)
    @x = x.to_i
    @y = y.to_i
  end
  
  def neighbor?(pt)
     ret = ((pt.x <= (@x + 1)) && (pt.x >= (@x - 1))) && 
           ((pt.y >= (@y - 1)) && (pt.y <= (@y + 1))) &&
           !((pt.y == @y) && (pt.x == @x)) 
    ret
  end
  
  def self.get_neighbors(pt)
    [Point.new(pt.x - 1, pt.y - 1),
      Point.new(pt.x - 1, pt.y),
      Point.new(pt.x - 1, pt.y + 1),
      Point.new(pt.x, pt.y - 1),
      Point.new(pt.x, pt.y + 1),
      Point.new(pt.x + 1, pt.y - 1),
      Point.new(pt.x + 1, pt.y),
      Point.new(pt.x + 1, pt.y + 1)]
  end
  
  def point_in_set(set)
    set.each do |item|
      if (item.x == @x) && (item.y == @y)
        return true
      end
    end
    false
  end  
end

class World
  attr_accessor :cells
  
  def initialize(width = 800, height = 600, num=(width * height / 30))
    @cells = []
    @delay_count = 0
    @delay_max = 1
    @width = width
    @height = height
          
    if ARGV.length > 0
      if ARGV[ARGV.length - 1] != 'blank'
        load_seed(ARGV[ARGV.length - 1])   
      end
    else
      randomize_cells
    end
  end
  
  def draw(drawer)
    self.cells.each do |cell|
      drawer.draw_point(cell.location.x.to_i, cell.location.y.to_i) if cell.status == 0
    end
    @delay_count += 1
    if @delay_count >= @delay_max
      @delay_count = 0

       # TODO
      self.tick
    end
  end
  
  def update(drawer)
    # nop for now... ???
  end
 
  def load_seed(file_path)
    initialize_cells
 
    File.open(file_path) do |file|
      while (line = file.readline) && (!file.eof?)
        next if line.size < 3
        next if line[0] == "#"
        
        (x, y) = line.split(',')
        add_cell(Cell.new(x, y, self))
      end
    end
  end
  
  def randomize_cells
    initialize_cells
    for i in 1..1000 do
      x = rand(@width)
      y = rand(@height)
      add_cell(Cell.new(x, y, self))
    end
  end
  
  def initialize_cells
    @cells = []
  end

  def add_cell(cell)
    found = false
    @cells.each do |c|
      if (c.location.x == cell.location.x) && (c.location.y == cell.location.y)
        found = true
        break
      end
    end
    unless found
       @cells << cell
    end
  end
  
  def tick
    @cells.each do |cell| 
      if (cell.neighbors.count <= 1) || (cell.neighbors.count > 3)        
        cell.status = -1
      elsif (cell.neighbors.count == 2) || (cell.neighbors.count == 3)
        cell.status = 0
      else 
        cell.status = -1
      end
    end
    
    # iterate cells to check about reproduction
    checked_locations = []
    @cells.each do |cell|
      cell.empty_neighbors.each do |empty_cell|        
        if empty_cell.point_in_set(checked_locations)
          next
        end
        checked_locations << empty_cell
        
        if self.live_neighbors(empty_cell).count == 3
          # create new cell for next round
          new_cell = Cell.new(empty_cell.x, empty_cell.y, self)
          new_cell.status = 1
        end
        
      end
    end
    update_world
  end
     
   def update_world
     @cells.delete_if { |c|
       c.status == -1
     }
     
     @cells.each do |c|
       if c.status == 1
         c.status = 0
       end
     end
   end
     
  def cell_at(x,y)
    @cells.each do |cell|
      if (cell.location.x == x) && (cell.location.y == y)
        return cell
      end
    end
    nil
  end         
  
  def live_neighbors(pt)
    ret = []
    neighbors = Point.get_neighbors(pt)
    
    @cells.each do |cell|
      if cell.status == 1
        next
      end
      
      if cell.location.point_in_set(neighbors)
        ret << cell
      end
    end
    ret
  end
end

class Cell
  attr_accessor :location, :status
  
  def initialize(x,y, world)
    @location = Point.new(x,y)
    @world = world
    @world.add_cell(self)
    @status = 0    
  end
  
  def neighbors
    ret = []
    @world.cells.each do |cell|
      if (cell == self) || (cell.status == 1)
        next
      end
            
      if cell.location.neighbor?(@location)
        ret << cell
      end
    end
    ret
  end
  
  def empty_neighbors
    ret = Point.get_neighbors(Point.new(location.x, location.y))
    ret.delete_if {|p|
      tcell = @world.cell_at(p.x, p.y)
      !(tcell.nil? || tcell.status == 1)
    }
    ret
  end
  
end

