require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name        = "geocerts"
    gem.summary     = %Q{A Ruby library for interfacing with the GeoCerts REST API}
    gem.description = %Q{A Ruby library for interfacing with the GeoCerts REST API}
    gem.email       = "support@geocerts.com"
    gem.homepage    = "http://www.geocerts.com/"
    gem.authors     = ["GeoCerts, Inc."]
    
    gem.add_dependency('relax', '>=0.1.2')
    
    gem.add_development_dependency('thoughtbot-shoulda',      '>=2.10.2')
    gem.add_development_dependency('thoughtbot-factory_girl', '>=1.2.2')
    gem.add_development_dependency('mocha',                   '>=0.9.5')
    gem.add_development_dependency('fakeweb',                 '>=1.2.2')
    
  end

rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end




task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION.yml')
    config = YAML.load(File.read('VERSION.yml'))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "geocerts #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

