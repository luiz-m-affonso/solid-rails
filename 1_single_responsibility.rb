# Every module or class should have responsibility over a single part of functionality
# and that responsibility should be entirely encapsulated
# Hatchbox
class Server < ApplicationRecord
  has_many :apps
  validates :name, presence: true
end

class Server::Setup < Server::SSH
  def perform
    start_ssh self, as: "root" do |ssh|
      ssh.execute "apt install ruby"
      ssh.execute "git clone git@github.com:username/repo.git"
    end
  end
end

class Server::Deploy < Server::SSH
  def perform
    start_ssh self, as: "root" do |ssh|
      ssh.execute "cd repo"
      ssh.execute "git remote update"
      ssh.execute "touch tmp/restart.txt"
    end
  end
end

class Server::SSH
  def start_ssh as: "deploy", &block
    Net::SSH.start self.ip do |ssh|
      block.call ssh
    end
  end
end