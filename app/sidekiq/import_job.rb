class ImportJob
  include Sidekiq::Job
  require 'csv'
  require 'json'
  def perform(file)
    # Do something
    CSV.open("import.csv", "w") do |csv| #open new file for write
      JSON.parse(File.open(file).read).each do |hash| #open json to parse
        csv << hash.values #write value to file
      end
    end

    file = File.open("import.csv")
    csv = CSV.parse(file, headers: true, col_sep: ',')
    csv.each do |row|
      user_hash = {}
      user_hash[:firstname] = row['firstname']
      user_hash[:lastname] = row['lastname']
      user_hash[:email] = row['Email']
      user_hash[:password] = row['password']
      user_hash[:password_confirmation] = row['password_confirmation']
      User.create(firstname: row['firstname'], lastname: row['lastname'], email: row['email'], password: row['password'])
      puts "Imported"
    end
  end
end
