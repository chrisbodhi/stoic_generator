require './app'
require 'rake'

task :generate_tweet do
  s = make_sentence
  file_name = "./tweets/#{Time.now.strftime("%Y-%b-%d")}.md"
  # Create, write to file
  File.open(file_name, "w") { |f| f.write(s) }

  puts "Added tweet to " + file_name
end

task :post do
  puts "do the post"
end