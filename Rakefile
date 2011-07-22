# require 'rubygems'
# require 'rake'
# 
# begin
#   require 'jeweler'
#   Jeweler::Tasks.new do |gem|
#     # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
#     gem.name = "oa-vkontakte_alexandrov"
#     gem.homepage = "http://github.com/igor-alexandrov/oa-vkontakte"
#     gem.license = "MIT"
#     gem.summary = %Q{VKontakte OmniAuth module with view helpers}
#     gem.description = %Q{Include this gem into your project with OmniAuth gem and you will get VKontakte login in one line of code.}
#     gem.email = "igor.alexandrov@gmail.com"
#     gem.authors = ["Igor Alexandrov"]
#     gem.add_dependency 'oa-core', '>= 0.2.0.beta4'
#     gem.add_development_dependency "rspec", ">= 1.2.9"
#     gem.add_development_dependency "yard", ">= 0"
#   end
#   Jeweler::RubygemsDotOrgTasks.new
# rescue LoadError
#   puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
# end
#   
# 
# require 'spec/rake/spectask'
# Spec::Rake::SpecTask.new(:spec) do |spec|
#   spec.libs << 'lib' << 'spec'
#   spec.spec_files = FileList['spec/**/*_spec.rb']
# end
# 
# Spec::Rake::SpecTask.new(:rcov) do |spec|
#   spec.libs << 'lib' << 'spec'
#   spec.pattern = 'spec/**/*_spec.rb'
#   spec.rcov = true
# end
# 
# task :spec => :check_dependencies
# 
# task :default => :spec
# 
# begin
#   require 'yard'
#   YARD::Rake::YardocTask.new
# rescue LoadError
#   task :yardoc do
#     abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
#   end
# end



require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "oa-vkontakte_alexandrov"
  gem.homepage = "http://github.com/igor-alexandrov/oa-vkontakte"
  gem.license = "MIT"
  gem.summary = %Q{VKontakte OmniAuth module with view helpers}
  gem.description = %Q{Include this gem into your project with OmniAuth gem and you will get VKontakte login in one line of code.}
  gem.email = "igor.alexandrov@gmail.com"
  gem.authors = ["Igor Alexandrov"]
  gem.add_dependency 'oa-core', '>= 0.2.0.beta4'
  gem.add_development_dependency "rspec", ">= 1.2.9"
  gem.add_development_dependency "yard", ">= 0"
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

require 'rcov/rcovtask'
Rcov::RcovTask.new do |test|
  test.libs << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
  test.rcov_opts << '--exclude "gems/*"'
end

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "oa-vkontakte_alexandrov #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
