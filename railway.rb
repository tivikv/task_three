class Station

  attr_accessor :name, :trains

  def initialize(name)
    @name = name
    @trains= []
  end

  #Принимает поезда
  def take_train(train)
    @trains << train
    puts "Поезд номер #{train} прибыл на станцию #{name}"
  end

  #Отправляет поезда
  def send_train(train)
    @trains.delete(train)
    train.station = nil
    puts "Поезд номер #{train} отправляется со станции #{name}"
  end

  #Возвращает список поездов
  def list_trains
    puts "Все поезда на станции #{name}: "
    @trains.each {|train| puts train.number_train}
  end

  #Возращает список грузовых и пассажирских поездов
  def list_trains_type (type)
    puts "#{type} поезда на станции #{name}:"
    @trains.each { |train| puts train.number_train if train.type == type}
  end

end

class Route

  attr_accessor :st_start, :st_end, :stations

  def initialize (st_start, st_end)
    @st_start = st_start
    @st_end = st_end
    @stations = [st_start, st_end]
    puts "Маршрут: #{st_start} - #{st_end}"
  end

  #Добавляет промежуточную станцию
  def add_station (station)
    @stations.insert(1, station)
    puts "Добавляем промежуточную станцию #{station}"
  end

  #Удаляет промежуточную станцию
  def delete_station(station)
    @stations.delete(station)
    puts "Удаляем промежуточную станцию #{station}"
  end

  #Выводит список всех станций
  def p_stations
    puts "Станции: #{@stations}"
  end
end

class Train

  TYPE = [:passenger, :cargo]

  attr_accessor :speed, :number_train, :quantity_car, :route, :station
  attr_reader :type

  def initialize(number_train, type, quantity_car)
    @number_train = number_train
    @type = type
    @quantity_car = quantity_car
    @speed = 0
  end

  #Возвращает текущую скорость
  def current_speed
    self.speed
  end

  #Тормозит
  def stop
    self.speed = 0
  end

  #Прицепляет вагоны
  def add_car
    if @speed == 0
      @quantity_car +=1
      puts "К поезду номер #{number_train} прицеплен вагон!"
    else
      puts "Поезд номер #{number_train} движется, вагоны прицепить невозможно!"
    end
  end

  #Отцепляет вагоны
  def delete_car
    if @speed == 0
      @quantity_car -=1
      puts "От поезда номер #{number_train} отцеплен вагон!"
    else
      puts "Поезд номер #{number_train} движется, вагоны отцепить невозможно!"
    end
  end

  #Принимает маршрут следования
  def train_route(route)
    self.route = route
    puts "Задан маршрут для поезда номер #{number_train}"
  end


  #При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
  def go_station(station)
    if route.nil?
      puts "Нет маршрута"
    elsif @station == station
      puts "Поезд #{@number} уже на станции #{@station.name}"
    elsif
      route.stations.include?(station)
      @station.send_train(self) if @station
      @station = station
      station.take_train(self)
    else
      puts "Ошибка. Станции #{station} нет в маршруте #{route}."
    end
  end

  #Возвращает предыдущую станцию, текущую, следующую, на основе маршрута
  def returns_stations
    if route.nil?
      puts "Нет маршрута"
    else
      current_station = route.stations.index(station)
      puts "Поезд #{@number_train} на станции #{station.name}"
      puts "Следующая станция для поезда #{@number_train}: #{route.stations[current_station + 1].name}" if current_station != route.stations.length- 1
      puts "Предыдущая станция для поезда #{@number_train}: #{route.stations[current_station - 1].name}" if current_station != 0
    end
  end

end

station = Station.new("Саранск")
station_1 = Station.new("Москва")
station_2 = Station.new("Калининград")
station_3 = Station.new("Прекрасноедалеко")
station_4 = Station.new("Казань")
station_5 = Station.new("Саров")
route_1 = Route.new(station_1, station_3)
route_1.add_station(station_2)
route_1.add_station(station_4)
route_1.add_station(station_5)
route_1.p_stations
route_1.delete_station(station_4)
route_1.p_stations
train = Train.new(154, "passenger", 15)
train_1 = Train.new(2, "passenger", 5)
train_2 = Train.new(158, "cargo", 65)
train_3 = Train.new(10, "cargo", 7)
p train.add_car
p train.speed = 100
p train.delete_car
train.train_route(route_1)
train.go_station(station_3)
train.go_station(station_2)
station_2.list_trains
station_3.list_trains
train.go_station(station_2)
train.go_station(station_3)
station_3.list_trains
station_2.take_train(train_1)
station_2.take_train(train_2)
station_2.take_train(train_3)
station_2. list_trains
train.returns_stations
train_1.returns_stations
station_1. list_trains
station_2.list_trains_type("passenger")
station_1.list_trains_type("cargo")
