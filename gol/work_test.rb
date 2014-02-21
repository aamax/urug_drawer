require './gol.rb'

describe World do
  before :each do
    @world = World.new(80, 60)  
    @cell = Cell.new(5,5, @world)        
  end
  
  it "should have one cell" do 
    
    
    @world.cells.count.should == 1
  end
end


