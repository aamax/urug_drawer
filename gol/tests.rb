require './gol.rb'
#require 'pry'

describe Point do
  before :each do
    @p = Point.new(5, 5)
  end
end

describe Cell do
  before :each do
    @world = World.new(80,60)  
    @cell = Cell.new(5,5, @world)    
  end
  
  it "should have no neighbors if it isn't touching any cells" do
    @cell.neighbors.should == []
  end
  
  it "should detect a neighbor at the NW" do
    neighbor = Cell.new(4,4, @world)
    @cell.neighbors.should == [neighbor]
  end
  
  it "should detect a neighbor at the N" do
    neighbor = Cell.new(5,4, @world)
    @cell.neighbors.should == [neighbor]
  end
  
  it "should detect a neighbor at the NE" do
    neighbor = Cell.new(6,4, @world)
    @cell.neighbors.should == [neighbor]
  end
  
  it "should detect a neighbor at the E" do
    neighbor = Cell.new(6,6, @world)
    @cell.neighbors.should == [neighbor]
  end
  
  it "should detect a neighbor at the SE" do
    neighbor = Cell.new(6,6, @world)
    @cell.neighbors.should == [neighbor]
  end
  
  it "should detect a neighbor at the S" do
    neighbor = Cell.new(5,6, @world)
    
    @cell.neighbors.should == [neighbor]
  end
  
  it "should detect a neighbor at the SW" do
    neighbor = Cell.new(4,6, @world)
    @cell.neighbors.should == [neighbor]
  end
  
  it "should detect a neighbor at the W" do
    neighbor = Cell.new(5,4, @world)
    @cell.neighbors.should == [neighbor]
  end

  it "should not detect a neighbor if it's not touching" do
    neighbor = Cell.new(5,7, @world)
    @cell.neighbors.should == []
  end
  
  context "empty cell" do
    before :each do
      @empties = @cell.empty_neighbors
    end
    
    it "should return empty cell at NW" do
      found = false
      @empties.each do |pt|
        if (pt.x == @cell.location.x - 1) && (pt.y == @cell.location.y - 1)
          found = true
          break
        end
      end
      found.should == true
    end
  
    it "should return empty cell at N" do
      found = false
      @empties.each do |pt|
        if (pt.x == @cell.location.x) && (pt.y == @cell.location.y - 1)
          found = true
          break
        end
      end
      found.should == true
    end
      
    it "should return empty cell at W" do
      found = false
      @empties.each do |pt|
        if (pt.x == @cell.location.x - 1) && (pt.y == @cell.location.y)
          found = true
          break
        end
      end
      found.should == true
    end
      
    it "should return empty cell at SW" do
      found = false
      @empties.each do |pt|
        if (pt.x == @cell.location.x - 1) && (pt.y == @cell.location.y - 1)
          found = true
          break
        end
      end
      found.should == true
    end
      
    it "should return empty cell at E" do
      found = false
      @empties.each do |pt|
        if (pt.x == @cell.location.x + 1) && (pt.y == @cell.location.y)
          found = true
          break
        end
      end
      found.should == true
    end
      
    it "should return empty cell at NE" do
      found = false
      @empties.each do |pt|
        if (pt.x == @cell.location.x + 1) && (pt.y == @cell.location.y - 1)
          found = true
          break
        end
      end
      found.should == true
    end
      
    it "should return empty cell at S" do
      found = false
      
      @empties.each do |pt|
        if (pt.x == @cell.location.x) && (pt.y == @cell.location.y + 1)
          found = true
          break
        end
      end
      found.should == true
    end
      
    it "should return empty cell at SE" do
      found = false
      @empties.each do |pt|
        if (pt.x == @cell.location.x + 1) && (pt.y == @cell.location.y + 1)
          found = true
          break
        end
      end
      found.should == true
    end
      
    it "should return all empty cells for single cell" do
      @cell.empty_neighbors.count.should == 8  
    end
  end
end

describe World do
  before :each do
    @world = World.new(80, 60)  
    @cell = Cell.new(5,5, @world)    
  end

  context "on a tick" do
    it "should mark cells with no neighbors to die" do
      @world.tick
      @cell.status.should == -1
    end
    
    it "should mark cells with 1 neighbor to die" do
      neighbor = Cell.new(4,5,@world)
      @world.tick
      @cell.status.should == -1
      neighbor.status.should == -1
    end
    
    it "should mark cells with 2 neighbors to live" do
      neighbor = Cell.new(4,4,@world)
      neighbor2 = Cell.new(4,6,@world)
      @cell.neighbors.count.should == 2
      @world.tick
      @cell.status.should == 0
    end

    it "should mark cells with  neighbors to live" do
      neighbor = Cell.new(4,4,@world)
      neighbor2 = Cell.new(4,6,@world)
      neighbor3 = Cell.new(6,6,@world)
      @cell.neighbors.count.should == 3
      @world.tick
      @cell.status.should == 0
    end
    
    it "should mark cells with 4 neighbors to die" do
      neighbor = Cell.new(4,4,@world)
      neighbor2 = Cell.new(4,6,@world)
      neighbor3 = Cell.new(6,6,@world)
      neighbor4 = Cell.new(6,4,@world)
      @cell.neighbors.count.should == 4
      @world.tick
      @cell.status.should == -1
    end
    
    it "should create new cell if an empty cell has 3 neighbors" do
      neighbor2 = Cell.new(4,6,@world)
      neighbor3 = Cell.new(6,6,@world)
      @world.tick
      
      new_cell = @world.cell_at(5,6)
      new_cell.should_not be nil
      new_cell.status.should == 1
    end
    
  end

  context "live_neighbors" do
    it "should return cell for NW cell check" do
      c2 = Cell.new(4,6, @world)
      c2 = Cell.new(6,6, @world)
      set = @world.live_neighbors(Point.new(4,4))
      set.count.should == 1
      set[0].location.x.should == 5
      set[0].location.y.should == 5
    end
    
    it "should return cell for N cell check" do
      set = @world.live_neighbors(Point.new(5,4))
      set.count.should == 1
      set[0].location.x.should == 5
      set[0].location.y.should == 5
    end
    
    it "should return cell for NE cell check" do
      set = @world.live_neighbors(Point.new(6,4))
      set.count.should == 1
      set[0].location.x.should == 5
      set[0].location.y.should == 5
    end

    it "should return cell for W cell check" do
      set = @world.live_neighbors(Point.new(4,5))
      set.count.should == 1
      set[0].location.x.should == 5
      set[0].location.y.should == 5
    end
    
    it "should return cell for SW cell check" do
      set = @world.live_neighbors(Point.new(4,6))
      set.count.should == 1
      set[0].location.x.should == 5
      set[0].location.y.should == 5
    end

    it "should return cell for S cell check" do
      set = @world.live_neighbors(Point.new(5,6))
      set.count.should == 1
      set[0].location.x.should == 5
      set[0].location.y.should == 5
    end
    
    it "should return cell for SE cell check" do
      set = @world.live_neighbors(Point.new(6,6))
      set.count.should == 1
      set[0].location.x.should == 5
      set[0].location.y.should == 5
    end

    it "should return cell for E cell check" do
      set = @world.live_neighbors(Point.new(6,5))
      set.count.should == 1
      set[0].location.x.should == 5
      set[0].location.y.should == 5
    end    
  end
  
  
  
  
end

describe World do
  before :each do
    @world = World.new
  end
  
  it "should return live neighbor count for cells" do
    cell1 = Cell.new(1,1, @world)
    cell2 = Cell.new(1,2, @world)
    cell1.neighbors.count.should == 1
    cell2.neighbors.count.should == 1
    
    cell3 = Cell.new(1,5, @world)
    cell3.neighbors.count.should == 0
  end

  
  it "should get list of neighbors for a cell" do    
    cell = Cell.new(1,1, @world)
    @world.cells.length.should == 1
    cell = Cell.new(1,2, @world)
    @world.cells.length.should == 2
  end
  
   it "should kill all cells if only 2 exist" do
       cell = Cell.new(1,1, @world)
       cell = Cell.new(1,2, @world)
       
       @world.tick
       @world.cells.length.should == 0
     end
    
  
end

#  it "should kill all cells with only 1 neighbor" do
#    world = World.new
#    cell = Cell.new(Point.new(1,1), world)
#    cell = Cell.new(Point.new(1,2), world)
#    cell = Cell.new(Point.new(1,3), world)
#    world.tick
#    world.cells.length.should == 1
#  end
#
#
#  it "should create cells bordered by 3 neighbors" do
#    world = World.new
#    cell = Cell.new(Point.new(1,0), world)
#    cell = Cell.new(Point.new(0,2), world)
#    cell = Cell.new(Point.new(2,2), world)
#    world.tick
#    world.cells.length.should == 1
#  end
#
#  it "should kill cells with 4 or more neighbors" do
#    world = World.new
#    cell = Cell.new(Point.new(1,1), world)
#    cell = Cell.new(Point.new(1,2), world)
#    cell = Cell.new(Point.new(1,3), world)
#    cell = Cell.new(Point.new(2,1), world)
#    cell = Cell.new(Point.new(2,2), world)
#    cell = Cell.new(Point.new(2,3), world)
#    cell = Cell.new(Point.new(3,1), world)
#    cell = Cell.new(Point.new(3,2), world)
#    cell = Cell.new(Point.new(3,3), world)
#
#    world.tick
#    world.cells.length.should == 4
#  end
#
#end
