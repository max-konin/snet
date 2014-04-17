
namespace :neo4j do
  desc 'Drop database'
  task drop: :environment do
    Dir.glob(Rails.root.join('app/models/*')).each do |f|
      klass = File.basename(f, '.*').camelize.constantize
      klass.destroy_all if !klass.nil? && klass.is_a?(Class) && klass.ancestors.include?(Neo4j::ActiveNode)
    end
  end
end