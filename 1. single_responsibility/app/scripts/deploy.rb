class App::Deploy
  def perform
    app.servers.each do |server|
      Server::Deploy.new(server).perform
    end
  end
end