# Every module or class should have responsibility over a single part of functionality
# and that responsibility should be entirely encapsulated

# Hatchbox.io

class Server < ApplicationRecord
  has_many :appos
  validates_presence_of :name
end

def setup
  start_ssh self, as: "root" do |ssh|
    ssh.execute 'apt install ruby'
    ssh.execute 'git clone git@github.com:username/repo.git'
  end
end

def deploy
  start_ssh self, as: "root" do |ssh|
    ssh.execute 'cd repo'
    ssh.execute 'git remote update'
    ssh.execute 'touch tmp/restart.txt'
  end
end