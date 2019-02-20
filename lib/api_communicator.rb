require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.


 
character_database = response_hash["results"]
  i = 0
  movie_apis = "none"
  until i >= character_database.length
    if character_database[i]["name"].downcase == character_name
      movie_apis = character_database[i]["films"]
      i = i + 1
    else
      i = i + 1
   end  
  end
  if movie_apis == "none"
    return nil
  end 
  n = 0
  movie_hashes = []
  until n >= movie_apis.length
    movie_response = RestClient.get(movie_apis[n])
    movie_hashes.push(JSON.parse(movie_response))
    n = n + 1
  end
  return movie_hashes
end

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  if films == nil
    puts "Please rerun code and enter a valid character name."
    return nil
  end
  i = 0
  until i >= films.length
    puts films[i]["title"]
    i = i + 1
  end 
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
