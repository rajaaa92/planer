namespace :items do
  desc "create items from ideas, missions and problems"
  task create: :environment do
    %w(idea mission problem).each do |category|
      category.classify.constantize.all.each do |object|
        i = Item.new
        i.category = category
        i.name = object.name
        i.position = object.position
        i.user_id = object.user_id
        i.save
      end
    end
    puts Item.count
  end
end
