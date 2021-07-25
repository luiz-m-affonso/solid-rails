# Every module or class should have responsibility over a single part of functionality
# and that responsibility should be entirely encapsulated

# Hatchbox.io

class Server < ApplicationRecord
  has_many :appos
  validates_presence_of :name
end

#app/scripts/app/deploy.rb
class App::Deploy
  def perform
    app.servers.each do |server|
      Server::Deploy.new(server).perform
    end
  end
end

# app/scripts/servers/setup.rb
class Server::Setup < Server::SSH
  def perform
    start_ssh self, as: "root" do |ssh|
      ssh.execute 'apt install ruby'
      ssh.execute 'git clone git@github.com:username/repo.git'
    end
  end
end

# app/scripts/servers/create_database.rb
class Server::CreateDatabase < Server::SSH
  def perform(name, username, password); end
end

# app/scripts/servers/deploy.rb
class Server::Deploy < Server::SSH
  def deploy
    start_ssh self, as: "root" do |ssh|
      ssh.execute 'cd repo'
      ssh.execute 'git remote update'
      ssh.execute 'touch tmp/restart.txt'
    end
  end
end

# app/scripts/servers/ssh.rb
class Server::SSH
  def start_ssh as: 'deploy', &block
    Net::SSH.start self.ip do |ssh|
      block.call ssh
    end
  end

  def logger
    # ActionCable Logger-JSON-XML
  end
end