require 'sinatra'

def filenames
  names = Dir.entries('lyrics')
  names.delete_if { |name| name[0] == '.' }
  names.sort
end

def song_name(filename)
  filename.gsub(/\-/, ' ').gsub('.txt', '')
end

def menu_text
  string = "Welcome to the Christmas Carol Lyric Line! What song number would you like lyrics for?"
  filenames.each_with_index do |filename, i|
    string << "\n#{i + 1} #{song_name(filename)}"
  end
  string
end

def valid_options
  (1..filenames.size).collect { |i| i.to_s }
end

def filename(input)
  filenames[input.to_i - 1]
end

def lyrics(filename)
  File.read("lyrics/#{filename}")
end

post '/message' do
  if valid_options.include?(params['Body'])
    message = lyrics(filename(params['Body']))
  else
    message = menu_text
  end

  content_type 'text/xml'
  twiml(message)
end

def twiml(message)
  %Q{
<Response>
  <Message>
    #{message}
    \n--\nPowered by Twilio.com
  </Message>
</Response> }
end