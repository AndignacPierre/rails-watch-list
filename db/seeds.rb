# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'open-uri'
require 'json'
require 'faker'

# Define the API URL
api_url = 'https://tmdb.lewagon.com/movie/top_rated'

# Fetch data from the API
response = URI.open(api_url).read
data = JSON.parse(response)

# Extract movie results
movies = data['results']

# Clear existing movies if you want to refresh the data
Movie.destroy_all

# Seed movies from the API
movies.each do |movie|
  Movie.create!(
    title: movie['title'],
    overview: movie['overview'],
    poster_url: "https://image.tmdb.org/t/p/original#{movie['poster_path']}",
    rating: movie['vote_average']
  )
end

# Optionally, add fake lists and bookmarks
5.times do
  list = List.create!(name: Faker::Lorem.words(number: 3).join(' '))
  3.times do
    Bookmark.create!(
      comment: Faker::Lorem.sentence(word_count: 6),
      movie: Movie.order('RANDOM()').first,
      list: list
    )
  end
end

puts "Seeding completed!"
