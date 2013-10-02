%w(sinatra pusher dino yaml json).each do |lib|
  require lib
end

YAML.load_file('pusher.yml').each do |key, value|
  Pusher.send("#{key}=".to_sym, value)
end

# board = Dino::Board.new(Dino::TxRx.new)
# cannon = Dino::Components::Led.new(pin: 8, board: board)
sleep 2

# cannon.off

get '/' do
  haml :index
end

post '/notify' do
  Pusher['notification'].trigger!('notify', {})
end

# post '/launching' do
#   Pusher['cannon'].trigger!('launching', {})
# end