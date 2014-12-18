require 'sinatra'
require 'haml'

SONGS = %w{
  away-in-a-manger.txt
  do-you-hear-what-i-hear.txt
  frosty-the-snowman.txt
  hark-the-harald-angels-sing.txt
  have-yourself-a-merry-little-christmas.txt
  here-comes-santa-claus.txt
  it-came-upon-the-midnight-clear.txt
  jingle-bells.txt
  joy-to-the-world.txt
  let-it-snow.txt
  little-drummer-boy.txt
  o-christmas-tree.txt
  o-come-all-ye-faithful.txt
  rudolph-the-red-nosed-reindeer.txt
  silent-night.txt
  silver-bells.txt
  the-first-noel.txt
  winter-wonderland.txt }

post '/message' do
  filename = filename(params['Body'])
  text = File.read("lyrics/#{filename}")

  content_type 'text/xml'
  twiml(text)
end

def song_options
  (1..SONGS.size).collect { |i| i.to_s }
end

def filename(input)
  song_options.include?(input) ? SONGS[input.to_i - 1] : 'menu.txt'
end

def twiml(text)
  %Q{
  <Response>
    <Message>
      #{text}
    </Message>
  </Response> }
end

