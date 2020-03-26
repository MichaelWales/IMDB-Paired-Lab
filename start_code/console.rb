require_relative('./models/movie')
require_relative('./models/star')
require_relative('./models/casting')

require('pry-byebug')

Casting.delete_all()
Movie.delete_all()
Star.delete_all()

movie1 = Movie.new({'title' => "Iron Man", 'genre' => "Action"})
movie1.save()

movie2 = Movie.new({'title' => "Deadpool", 'genre' => "Romance"})
movie2.save()


star1 = Star.new({'first_name' => "Ryan", 'last_name' => "Reynolds"})
star1.save()

star2 = Star.new({'first_name' => "Morena", 'last_name' => "Baccarin"})
star2.save()

star3 = Star.new({'first_name' => "Brianna", 'last_name' => "Hildebrand"})
star3.save()

star4 = Star.new({'first_name' => "Robert", 'last_name' => "Downey Jnr."})
star4.save()


casting1 = Casting.new({'movie_id' => movie1.id, 'star_id' => star4.id, 'fee' => 80})
casting1.save()

casting2 = Casting.new({'movie_id' => movie2.id, 'star_id' => star1.id, 'fee' => 50})
casting2.save()

casting3 = Casting.new({'movie_id' => movie2.id, 'star_id' => star2.id, 'fee' => 40})
casting3.save()

casting4 = Casting.new({'movie_id' => movie2.id, 'star_id' => star3.id, 'fee' => 60})
casting4.save()


binding.pry
nil
