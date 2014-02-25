src = []

pwidth = 20
pheight = 20

File.open("./pulsar") do |file|
  while (line = file.readline) && (!file.eof?)
    next if line.size < 3
    next if line[0] == "#"

    (x, y) = line.split(',')


    x = x.to_i - 11
    y = y.to_i - 42

    src << [x,y]
  end
end


file = File.new("./newseed", 'w+')
  src.each do |val|
    vx = val[0] + 2
    vy = val[1] + 2

    srcx = vx

    file.write(vx.to_s + "," + vy.to_s + "\n")

    vx += pwidth
    file.write(vx.to_s + "," + vy.to_s + "\n")

    vx += pwidth
    file.write(vx.to_s + "," + vy.to_s + "\n")

    vx += pwidth
    file.write(vx.to_s + "," + vy.to_s + "\n")

    vx = srcx
    vy += pheight
    file.write(vx.to_s + "," + vy.to_s + "\n")

    vx += pwidth
    file.write(vx.to_s + "," + vy.to_s + "\n")

    vx += pwidth
    file.write(vx.to_s + "," + vy.to_s + "\n")

    vx += pwidth
    file.write(vx.to_s + "," + vy.to_s + "\n")

    vx = srcx
    vy += pheight
    file.write(vx.to_s + "," + vy.to_s + "\n")

    vx += pwidth
    file.write(vx.to_s + "," + vy.to_s + "\n")

    vx += pwidth
    file.write(vx.to_s + "," + vy.to_s + "\n")

    vx += pwidth
    file.write(vx.to_s + "," + vy.to_s + "\n")

    vx = srcx
    vy += pheight
    file.write(vx.to_s + "," + vy.to_s + "\n")

    vx += pwidth
    file.write(vx.to_s + "," + vy.to_s + "\n")

    vx += pwidth
    file.write(vx.to_s + "," + vy.to_s + "\n")

    vx += pwidth
    file.write(vx.to_s + "," + vy.to_s + "\n")

  end

file.write("\n\n\n")

file.close





