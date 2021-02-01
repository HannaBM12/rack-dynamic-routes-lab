class Item
  attr_accessor :name, :price
  @@all = []

  def initialize(name,price)
    @name = name
    @price = price
    @@all << self
  end

  def self.all
    @@all
  end
end


class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    
    if req.path.match(/items/)
      item_name = req.path.split("/items/").last
      item = Item.all.find{|i| i.name == item_name}
          if item != nil
            resp.write "#{item.price}"
          else 
            resp.write "Item not found"
            resp.status = 400
          end

    else
      resp.write "Route not found"
      resp.status = 404
    end

  resp.finish

  end
end 
