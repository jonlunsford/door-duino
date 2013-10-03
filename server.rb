%w(sinatra pusher dino yaml json).each do |lib|
  require lib
end

YAML.load_file('pusher.yml').each do |key, value|
  Pusher.send("#{key}=".to_sym, value)
end

board = Dino::Board.new(Dino::TxRx.new)
sensor = Dino::Components::Sensor.new(pin: "A0", board: board)
potentiometer = Dino::Components::Sensor.new(pin: "A1", board: board)
green_led = Dino::Components::Led.new(pin: 13, board: board)
red_led = Dino::Components::Led.new(pin: 10, board: board)

knock_sensitivity = 10

potentiometer.when_data_received do |data|
  knock_sensitivity = data
end

sensor.when_data_received do |data|
  puts knock_sensitivity
  if data.to_i >= knock_sensitivity
    red_led.send(:on)
    green_led.send(:off)
    Pusher["notification"].trigger!("notify", {message: "ALERT! Somebody is at the front door", type: "negative"})
    sleep 2
  else 
    green_led.send(:on)
    red_led.send(:off)
    Pusher["notification"].trigger!("notify", {message: "Phew... Nobody is at the front door", type: "positive"})
  end
end


get '/' do
  haml :index
end

post '/notify' do
  Pusher['notification'].trigger!('notify', {message: "ALERT!!!! REAL TIME!!!", type: "positive"})
  sensor.send(:on)
  sleep 2
  sensor.send(:off)
end