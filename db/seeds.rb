# frozen_string_literal: true

require 'open-uri'

puts 'Cleaning database...'
List.destroy_all
Bookmark.destroy_all
Movie.destroy_all

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
list = List.create!(name: 'Favourites')
file = URI.open('https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/NES-Console-Set.jpg/1200px-NES-Console-Set.jpg')
list.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
list.save

puts 'Creating bookmarks...'
3.times do
  Bookmark.create!(comment: 'Great movie!', movie: Movie.all.sample, list: List.all.sample)
end
