# frozen_string_literal: true

require 'open-uri'

puts 'Cleaning database...'
Movie.destroy_all
List.destroy_all
Bookmark.destroy_all

puts 'Creating movies...'
url = 'http://tmdb.lewagon.com/movie/top_rated'
response = JSON.parse(URI.open(url).read)

response['results'].each do |movie_hash|
  # create an instance with the hash
  Movie.create!(
    poster_url: "https://image.tmdb.org/t/p/w500#{movie_hash['poster_path']}",
    rating: movie_hash['vote_average'],
    title: movie_hash['title'],
    overview: movie_hash['overview']
  )
end

puts 'Creating lists...'
List.create!(name: 'Favourites')

puts 'Creating bookmarks...'
3.times do
  Bookmark.create!(comment: 'Great movie!', movie: Movie.all.sample, list: List.all.sample)
end
