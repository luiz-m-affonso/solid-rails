class Server::Setup < Server::SSH
  def perform
    start_ssh self, as: "root" do |ssh|
      ssh.execute 'apt install ruby'
      ssh.execute 'git clone git@github.com:username/repo.git'
    end
  end
end