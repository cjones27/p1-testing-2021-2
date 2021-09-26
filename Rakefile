# frozen_string_literal: true

require 'rubocop/rake_task'

task default: %w[test]

task :test do
  ruby 'test/model_tests.rb'
  ruby 'test/controller_tests.rb'
  ruby 'test/square_tests.rb'
  ruby 'test/board_map_tests.rb'
end

RuboCop::RakeTask.new(:lint) do |task|
  task.patterns = ['src/**/*.rb', 'test/**/*.rb']
  task.fail_on_error = false
end
