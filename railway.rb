class Station

  attr_accessor :name
  attr_reader :trains

  def initialize(name)
    @name = name
    @trains= []
  end

  #Принимает поезда
  def take_train(train)
    @trains << train
  end

  #Отправляет поезда
  def send_train(train)
    @trains.delete(train)
    train.stations = nil
  end


  #Возращает список грузовых и пассажирских поездов
  def list_trains_type (type)
    @trains.each { |train| puts train if train.type == type}
  end

end

class Route

  attr_accessor :start_station, :end_station
  attr_reader :stations

  def initialize (start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @stations = [start_station, end_station]
  end

  #Добавляет промежуточную станцию
  def add_station (station)
    @stations.insert(1, station)
  end

  #Удаляет промежуточную станцию
  def delete_station(station)
    @stations.delete(station)
  end

end

class Train

  TYPE = [:passenger, :cargo]

  attr_accessor :speed, :number_train, :quantity_car, :stations
  attr_reader :type, :route

  def initialize(number_train, type, quantity_car)
    @number_train = number_train
    @type = type
    @quantity_car = quantity_car
    @speed = 0
  end

  #Возвращает текущую скорость
  def current_speed
    @speed
  end

  #Тормозит
  def stop
    @speed = 0
  end

  #Прицепляет вагоны
  def add_car
    if @speed == 0
      @quantity_car +=1
    end
  end

  #Отцепляет вагоны
  def delete_car
    if @speed == 0
      @quantity_car -=1
    end
  end

  #Принимает маршрут следования и поезд автоматически помещается на первую станцию
  def train_route=(route)
    route.stations.first.send_train(self)
    @route = route
    @index_stations = 0
  end

  #Поезд движется на одну станцию вперед
  def move_forward
    @index_stations += 1 if @index_stations != route.stations.length - 1
    route.stations[@index_stations].name
  end

  #Поезд движется на одну станцию назад
  def move_back
    @index_stations -= 1 if @index_stations != 0
    route.stations[@index_stations].name
  end

  #текущую
  def current_station
    current_station = route.stations[@index_stations]
    current_station.name

  end
  #следующую
  def next_station
    route.stations[@index_stations + 1].name if @index_stations != route.stations.length - 1
  end
  #Возвращает предыдущую станцию
  def previous_station
    route.stations[@index_stations - 1].name if @index_stations != 0
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
route_1.stations
route_1.delete_station(station_4)
route_1.stations
train = Train.new(154, "passenger", 15)
train_1 = Train.new(2, "passenger", 5)
train_2 = Train.new(158, "cargo", 65)
train_3 = Train.new(10, "cargo", 7)
p train.add_car
p train.speed = 100
p train.delete_car
train.train_route=(route_1)
station_2.trains
station_3.trains

station_3.trains
station_2.take_train(train_1)
station_2.take_train(train_2)
station_2.take_train(train_3)
station_2.trains
p train.current_station
p train.move_forward
p train.move_forward
p train.move_forward

p train.move_back
p train.move_back
p train.move_back
