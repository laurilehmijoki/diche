desc "Run tests"
task :test do
  output = `find test -name *spec.rb | grep -v integration_spec`
  files = output.split(/\n/i)
  sh "rspec #{files.join(' ')}"
end

desc "Run integration tests – requires network connection and AWS DynamoDB credentials."
task :integrationtest do
  sh "rspec test --pattern '**/*_integration_spec.rb'"
end
