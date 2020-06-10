require_relative '../../config/environment'

namespace :db do
  desc 'Load database initial data'
  task :seed => :settings do |t|
    require 'sequel/core'
    require 'sequel/extensions/seed'
    Sequel.extension :seed 
    path = File.expand_path('../../db/seeds', __dir__)

    Sequel.connect(Settings.db.to_hash) do |db|
      Sequel::Seeder.apply(db, path)
    end
  end
end