class Server::SSH
  def start_ssh as: 'deploy', &block
    Net::SSH.start self.ip do |ssh|
      block.call ssh
    end
  end

  def logger; end
end