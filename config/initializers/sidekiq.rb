# frozen_string_literal: true

require 'sidekiq'
require 'sidekiq/web'
require 'sidekiq/cron/web'

schedule_file = 'config/schedule.yml'

if File.exist?(schedule_file) && Sidekiq.server?
  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
end

