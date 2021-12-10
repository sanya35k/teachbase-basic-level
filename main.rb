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
  attr_reader :stations, :trains

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

  ACTIONS = {
    1 => :create_station,
    2 => :create_train,
    3 => :add_carriage,
    4 => :remove_carriage,
    5 => :add_train_to_station,
    6 => :put_stations_list,
    7 => :put_trains_list,
    8 => :trains_on_stations
  }.freeze

  private

  attr_writer :stations, :trains

  def choose_action # rubocop:disable Metrics/MethodLength
    puts %(0 - Exit
1 - Create station
2 - Create train
3 - Add carriage to the train
4 - Remove carriage from the train
5 - Add train to the station
6 - List of stations
7 - List of trains
8 - List of stations and list of trains at the station
Choose your action:)
    gets.chomp.to_i
  end

  def create_station
    puts 'Enter station name:'
    station_name = gets.chomp
    stations << Station.new(station_name)
    puts "-Station #{station_name} successful created!"
  end

  def create_train # rubocop:disable Metrics/MethodLength
    puts %(Choose train type:
1 - Passenger
2 - Cargo)
    train_type = gets.chomp.to_i
    puts 'Enter train number:'
    train_number = gets.chomp
    case train_type
    when 1
      trains << PassengerTrain.new(train_number)
      puts "-Passenger train successful created with number - #{train_number}!"
    when 2
      trains << CargoTrain.new(train_number)
      puts "-Cargo train successful created with number - #{train_number}!"
    else
      'You entered invalid value!'
    end
  end

  def add_carriage # rubocop:disable Metrics/MethodLength
    train = choose_train
    if train
      case train.type
      when :passenger
        train.add_carriage(PassengerCarriage.new)
      when :cargo
        train.add_carriage(CargoCarriage.new)
      end
      puts '-Carriage successful added to the train!'
    else
      puts 'Train not found!'
    end
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

    puts "List of trains at the station #{station.name}: #{station.trains_list}"
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
