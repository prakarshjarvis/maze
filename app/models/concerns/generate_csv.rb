module GenerateCsv
  extend ActiveSupport::Concern
  require 'csv'

  class_methods do
    def to_csv(collection, count)
      CSV.generate(col_sep: ';') do |csv|
        csv << ["Id", "Email", "Posts Count", "Comments Count", "Likes Count"]
        collection.each do |record|
          if record.posts.count >= count.to_i
            csv << [record.id, record.email, record.posts.count, record.comments.count, record.likes.count]
          end
        end
      end
    end
  end
end