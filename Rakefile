
task "build" =>  %w[ schema.json ]

file "schema.json" => "src/schema.coffee" do
  sh "coffee src/schema.coffee > schema.json"
  sh "git add schema.json"
end


