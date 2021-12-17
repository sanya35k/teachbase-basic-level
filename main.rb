# frozen_string_literal: true

require_relative 'train'
require_relative 'route'
require_relative 'station'
require_relative 'carriage'
require_relative 'cargo_carriage'
require_relative 'cargo_train'
require_relative 'passenger_carriage'
require_relative 'passenger_train'

class Main # rubocop:disable Metrics/ClassLength
  attr_accessor :stations, :trains

  def initialize
    @stations = []
    @trains = []
  end

  def choose
    loop do
      action = choose_action
      break if action.zero?

      send(ACTIONS[action])
      puts 'Choose new action:'
    end
  end

  def invalid_value
    puts 'You entered invalid value!'
  end

  ACTIONS = {
    1 => :create_station,
    2 => :create_train,
    3 => :add_carriage,
    4 => :remove_carriage,
    5 => :add_train_to_station,
    6 => :put_stations_list,
    7 => :put_trains_list,
    8 => :trains_on_station,
    9 => :carriages_train
  }.freeze

  private

  def choose_action
    puts %(0 - Exit
1 - Create station
2 - Create train
3 - Add carriage to the train
4 - Remove carriage from the train
5 - Add train to the station
6 - List of stations\n7 - List of trains
8 - List of stations and list of trains at the station
9 - List of trains and list of carriages\nChoose your action:)
    choose_action_get_value
  end

  def choose_action_get_value
    change = gets.chomp.to_i
    if change <= 9 && change >= 0
      change
    else
      invalid_value
    end
  end

  def create_station
    puts 'Enter station name:'
    station_name = gets.chomp
    if find_station(station_name)
      puts 'Station with the same number already exists!'
    else
      stations << Station.new(station_name)
      puts "-Station #{station_name} successful created!"
    end
  rescue ArgumentError => e
    puts e.message
  end

  def find_station(name)
    stations.find { |x| return x if x.name == name }
  end

  def find_train(number)
    trains.find { |x| return x if x.number == number }
  end

  def create_train
    puts %(Choose train type:
1 - Passenger
2 - Cargo)
    train_type = gets.chomp.to_i
    puts 'Enter train number:'
    train_number = gets.chomp
    check_same_trains(train_number, train_type)
  rescue ArgumentError => e
    puts e.message
  end

  def check_same_trains(train_number, train_type)
    if find_train(train_number)
      puts 'Train with the same number already exists!'
    else
      create_train_type(train_type, train_number)
    end
  end

  def create_train_type(train_type, train_number)
    case train_type
    when 1
      trains << PassengerTrain.new(train_number)
      puts "-Passenger train successful created with number - #{train_number}!"
    when 2
      trains << CargoTrain.new(train_number)
      puts "-Cargo train successful created with number - #{train_number}!"
    else
      puts 'You entered invalid value!'
    end
  end

  def add_carriage
    train = choose_train
    if train
      add_carriage_type(train)
    else
      puts 'Train not found!'
    end
  end

  def add_carriage_type(train)
    puts 'Enter company name:'
    company_name = gets.chomp
    case train.type
    when :passenger
      pass_type(train, company_name)
    when :cargo
      c_type(train)
    end
    puts '-Carriage successful added to the train!'
  end

  def pass_type(train, company_name)
    puts 'Enter the number of seats:'
    seats = gets.chomp.to_i
    train.add_carriage(PassengerCarriage.new(company_name, seats))
  end

  def c_type(train, company_name)
    puts 'Enter value volume:'
    volume = gets.chomp.to_i
    train.add_carriage(CargoCarriage.new(company_name, volume))
  end

  def remove_carriage
    train = choose_train
    if train
      if train.remove_carriage
        puts '-Carriage successful removed!'
      else
        puts 'No carriages on the train!'
      end
    else
      puts 'Train not found!'
    end
  end

  def add_train_to_station
    station = choose_station
    return puts 'Station not found!' unless station

    train = choose_train
    return puts 'Train not found!' unless train

    station.add_train(train)
    puts "-Train #{train.number} successful added to the station #{station.name}!"
  end

  def stations_list
    stations.map(&:name)
  end

  def trains_list(type = nil)
    if type
      trains.map { |t| t.number if t.type == type }.compact
    else
      trains.map(&:number)
    end
  end

  def trains_on_station
    station = choose_station
    return puts 'Station not found' unless station

    puts "List of trains at the station #{station.name}:"
    station_info(station)
  end

  def station_info(station)
    station.each_train do |train|
      puts "-Number: #{train.number}, Type: #{train.type}, Carriages: #{train.carriages.count}"
    end
  end

  def train_info(train)
    case train.type
    when :cargo
      cargo_type(train)
    when :passenger
      passenger_type(train)
    end
  end

  def cargo_type(train)
    i = 0
    train.each_carriage do |carriage|
      i += 1
      puts "-Carriage: #{i}, Type: #{carriage.type}, Free volume: #{carriage.free_value_volume},
Busy volume: #{carriage.busy_value_volume}"
    end
  end

  def passenger_type(train)
    i = 0
    train.each_carriage do |carriage|
      i += 1
      puts "-Carriage: #{i}, Type: #{carriage.type}, Free seats: #{carriage.free_seats_passengers},
Busy seats: #{carriage.busy_seats_passengers}"
    end
  end

  def carriages_train
    train = choose_train
    return puts 'Trains not found' unless train

    puts "List of carriages train #{train.number}:"
    train_info(train)
  end

  def choose_train
    puts "List of trains: #{trains_list}"
    puts 'Enter train number:'
    train_number = gets.chomp
    train_by_number(train_number)
  end

  def choose_station
    puts "List of stations: #{stations_list}"
    puts 'Enter station name:'
    station_name = gets.chomp
    station_by_name(station_name)
  end

  def train_by_number(number)
    trains.select { |train| train.number == number }.first
  end

  def station_by_name(name)
    stations.select { |station| station.name == name }.first
  end

  def put_stations_list
    puts stations_list.to_s
  end

  def put_trains_list
    puts trains_list.to_s
  end
end

Main.new.choose
