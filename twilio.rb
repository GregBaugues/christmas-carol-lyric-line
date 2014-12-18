require 'sinatra'
require 'haml'


post '/message' do
  # filename = filename(params['Body'])
  # text = File.read("lyrics/#{filename}")

  content_type 'text/xml'
  twiml(menu)
end

def song_options
  (1..SONGS.size).collect { |i| i.to_s }
end

def filenames
  names = Dir.entries('lyrics')
  names.delete_if { |name| name[0] == '.' }
  names
end

def menu
  string = "Reply with the song number you'd like:"
  filenames.each_with_index do |filename, i|
    name = song_name(filename)
    string << "\n#{i + 1} #{name}"
  end
  string
end

def song_name(filename)
  filename.gsub(/\-/, ' ').gsub('.txt', '')
end

def twiml(text)
  %Q{
  <Response>
    <Message>
      #{text}
    </Message>
  </Response> }
end

