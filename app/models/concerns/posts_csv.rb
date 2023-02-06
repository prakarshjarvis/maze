
module PostsCsv
  extend ActiveSupport::Concern
  require 'csv'

  class_methods do
    def to_csv(collection)
      CSV.generate(col_sep: ';') do |csv|
        csv << ["Title", "Description", "Comments count", "Likes count" ]
        # csv << column_names
        collection.find_each do |record|
          csv << [record.title, record.body, record.comments.count, record.likes.count]
        end
      end
    end
  end
end