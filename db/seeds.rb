5.times do |n|
  Category.create(title: "blabla#{n + 1}")
end
