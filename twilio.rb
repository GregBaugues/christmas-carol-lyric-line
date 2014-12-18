require 'sinatra'
require 'haml'

post '/message' do
  if menu_options.include?(params['Body'])
    file = filename(params['Body'])
    message = File.read("lyrics/#{file}")
  else
    message = menu_text
  end

  content_type 'text/xml'
  twiml(message)
end

def menu_options
  (1..filenames.size).collect { |i| i.to_s }
end

def filename(input)
  filenames[input.to_i - 1]
end

def filenames
  names = Dir.entries('lyrics')
  names.delete_if { |name| name[0] == '.' }
  names
end

def song_name(filename)
  filename.gsub(/\-/, ' ').gsub('.txt', '')
end

def menu_text
  string = "Reply with the song number you'd like:"
  filenames.each_with_index do |filename, i|
    name = song_name(filename)
    string << "\n#{i + 1} #{name}"
  end
  string
end

def twiml(message)
  %Q{
  <Response>
    <Message>
      #{message}
    </Message>
  </Response> }
end

