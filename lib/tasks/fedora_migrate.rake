desc 'please migrate!'
task migrate: :environment do
  results = FedoraMigrate.migrate_repository(namespace: "avalon", options: {})
  puts results
end
