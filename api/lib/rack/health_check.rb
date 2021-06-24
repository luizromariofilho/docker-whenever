# frozen_string_literal: true

module Rack
  class HealthCheck
    def call(_env)
      status = {
        redis: {
          connected: redis_connected
        },
        sidekiq: {
          connected: sidekiq_connected
        },
        postgres: {
          connected: postgres_connected,
          migrations_updated: postgres_migrations_updated
        }
      }

      [200, {}, [status.to_json]]
    end

    protected

    def redis_connected
      res = ::Redis.new(url: ENV['REDIS_HOST_URL']).ping
      res == 'PONG'
    rescue StandardError
      false
    end

    def sidekiq_connected
      ::Sidekiq.redis do |r|
        res = r.ping
        res == 'PONG'
      end
    rescue StandardError
      false
    end

    def postgres_connected
      ApplicationRecord.establish_connection
      ApplicationRecord.connection
      ApplicationRecord.connected?
    rescue StandardError
      false
    end

    def postgres_migrations_updated
      return false unless postgres_connected

      !ApplicationRecord.connection.migration_context.needs_migration?
    end
  end
end
