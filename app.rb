require 'sinatra'
require 'marky_markov'
require 'twitter'
require 'haml'
require 'zurb-foundation'
require 'sass'

def get_sentence
  markov = MarkyMarkov::TemporaryDictionary.new
  markov.parse_file "meditations.txt"
  sentence = markov.generate_n_sentences 1
  markov.clear! # Clear the temporary dictionary.
  sentence  
end

def shorten(sentence)
  sentence = sentence[0..276] + '...'
end

def clean_sentence(sentence)
  sentence = shorten(sentence) if sentence.length > 280
  sentence = sentence.strip
  sentence = sentence.chop if sentence[-1] == ','
  if sentence[-1] == '.' || sentence[-1] == '?' || sentence[-1] == '!'
  else
    sentence + ['.', '?', '!'].sample
  end
  sentence[0] = sentence[0].upcase
  sentence
end

def make_sentence
  clean_sentence(get_sentence)
end

def twitter_post
  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV['CONSUMER_KEY']
    config.consumer_secret     = ENV['CONSUMER_SECRET']
    config.access_token        = ENV['ACCESS_TOKEN']
    config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
  end

  client.update(make_sentence)
end

get '/' do
  haml :index
end
