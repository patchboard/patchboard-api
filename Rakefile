require "starter/tasks/npm"
require "starter/tasks/npm/release"
require "starter/tasks/git"

task "build" =>  %w[ schema.json test_api.json ]

file "schema.json" => "src/schema.coffee" do
  sh "coffee src/schema.coffee > schema.json"
  sh "git add schema.json"
end

file "test_api.json" => "src/test_api.coffee" do
  sh "coffee src/test_api.coffee > test_api.json"
  sh "git add test_api.json"
end


