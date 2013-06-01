MongoMapper.connection = Mongo::Connection.new('mac', 27017)
MongoMapper.database = "#items_#{Rails.env}"

if defined?(PhusionPassenger)
  PhusionPassenger.on_event(:starting_worker_process) do |forked|
    MongoMapper.connection.connect if forked
  end
end
