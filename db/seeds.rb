# frozen_string_literal: true

# 10 random user with password 123456.
10.times do
  User.create!(
    email: Faker::Internet.email,
    password: '123456',
    password_confirmation: '123456',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
end

# 50 random post with random user created above.
50.times do
  post = Post.create!(
    title: Faker::Book.title,
    description: Faker::Lorem.paragraphs(number: 5).join("\n"),
    user: User.order('RANDOM()').first,
    status: Post.statuses.keys.sample,
    tag_list: Faker::Lorem.words
  )
  post.update(published_at: Time.now) if post.published?
end
