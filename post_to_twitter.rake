desc "This task populates the Workout database."

task :post_to_twitter => :environment do
  twitter_post
end