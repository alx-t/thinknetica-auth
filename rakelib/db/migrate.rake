namespace :db do
  desc 'Run database migrations'
  task :migrate, %i[version] => :settings do |t, args|
    require 'sequel/core'
    Sequel.extension :migration

    Sequel.connect(Settings.db.to_hash) do |db|
      migrations = File.expand_path('../../db/migrations', __dir__)
      version = args.version.to_i if args.version

      Sequel::Migrator.run(db, migrations, target: version)
      
      db.extension :schema_dumper
      schema = db.dump_schema_migration(indexes: true, foreign_keys: true, index_names: true)
      File.open(File.expand_path('../../db/schema.rb', __dir__), 'w') { |f| f.write(schema) }
    end
  end
end