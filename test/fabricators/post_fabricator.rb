# frozen_string_literal: true

Fabricator(:post) do
  user { Fabricate(:user) }
  title { Faker::Book.title }
  description { Faker::Lorem.paragraph }
  main_image { Rack::Test::UploadedFile.new(File.new(Rails.root.join('test/fixtures/files/valid_main_image.jpg'))) }
end
