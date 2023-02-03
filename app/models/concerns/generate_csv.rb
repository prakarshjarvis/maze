module GenerateCsv
  extend ActiveSupport::Concern
  require 'csv'

  class_methods do
    def to_csv(collection)
      # wanted_columns = [:id, :shipname, :shipaddress, :shipcity, :shipstate, :shipzip]
      CSV.generate(col_sep: ';') do |csv|
        csv << ["Id", "Email", "Posts Count", "Likes Count"]
        # csv << column_names
        collection.each do |record|
          if record.posts.count > 0
            csv << [record.id, record.email, record.posts.count, record.likes.count]
          end
        end
      end
    end
  end
end