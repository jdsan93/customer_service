module Rabbitmq
  class Connection
    def self.build
      Bunny.new(ENV.fetch("RABBITMQ_URL"), automatically_recover: true)
    end
  end
end

