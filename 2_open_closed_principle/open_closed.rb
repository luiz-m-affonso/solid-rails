# Software entities should be open for extension but closed for modification

class Server
  def provision
    klass = "Provider::#{provider.classify}".safe_constantize
    instance = klass.new(self)
    instance.add_ssh_key
    id = instance.create
    instance.tatus(id)
  end
end

class Provider::Base
  def initialize(server)
    @server = server
  end

  def add_ssh_key
    raise NotImplementedError
  end

  def create
    raise NotImplementedError
  end

  def status(id)
    raise NotImplementedError
  end
end

class Provider::DigitalOcean < Provider::Base
  def add_ssh_key

  end

  def create

  end

  def status(id)

  end
end

class Provider::Linode < Provider::Base
  def add_ssh_key; end

  def create; end

  def status(id); end
end

class Provider::Aws < Provider::Base
  def add_ssh_key; end

  def create; end

  def status(id); end
end