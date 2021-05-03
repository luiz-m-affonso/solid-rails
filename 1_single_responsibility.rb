class Server < ApplicationRecord
  has_many :apps
  validates :name, presence: true
end

class Server
  def setup
    start_ssh self, as: "root" do |ssh|
      ssh.execute "apt install ruby"
      ssh.execute "git clone git@github.com:username/repo.git"
    end
  end

  def deploy
    start_ssh self, as: "root" do |ssh|
      ssh.execute "cd repo"
      ssh.execute "git remote update"
      ssh.execute "touch tmp/restart.txt"
    end
  end

  
end