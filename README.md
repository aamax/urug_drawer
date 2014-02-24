Conway's Game of Life

WHY?
I've done gol a few times during code retreats but the code is always thrown away and the app is never finished.  I wanted to actually finish it for once.

It's straight ruby (I built it with 1.9.2-p290)
The code passes all tests and I think it's in pretty good shape as far as it following Conway's rules
but it isn't an elegant implementation by any means.

It was fun to build, took me longer to do than I had anticipated.  the hardest part was
having cells born if they have 3 live neighbors.

The work was done completely with TDD

The original spec called for an infinite playing field and my implementation supports that although the visual 
part is on a finite playing field.


I used the gosu library for the display (with the help of Matt Nielsen from the URUG group)
to run the game just enter the following from a command prompt in the directory:

ruby game.rb test_seed

once the game is running the 'esc' key will end it.

if you don't include a seed file it will randomly fill the playing space and you'll get an arbitrary cell population.
the random population code isn't working well at all - next thing for me to play with.

to run the tests enter:
rspec tests.rb blank






