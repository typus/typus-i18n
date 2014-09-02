require "bundler/gem_tasks"

require 'rake/testtask'
require 'yaml'

task :default => :test

Rake::TestTask.new(:test) do |t|
  t.description = "run all tests"
  t.libs += %w(lib test)
  t.test_files = FileList['test/**/*_test.rb']
end

task :make_template do
  # validate locale
  locale = ENV['LOCALE']
  locale_regex = /^[a-z]{2}(\-[A-Z]{2})?$/
  unless (locale && (locale != 'en') && (locale =~ locale_regex)) 
    raise "Please set a correct locale (either LOCALE=xx or LOCALE=xx-YY)." 
  end

  # check if file exists
  new_file = "config/locales/typus.#{locale}.yml"
  if File.exist?(new_file)
    raise "The file #{new_file} exists, I won't overwrite it with an empty template." 
  end

  # all good. let's make the new file
  yml_string = File.read('config/locales/typus.de.yml')
  out = yml_string
    .gsub(/"(.+)"/, '""')
    .gsub(/'(.+)'/, '""')
    .gsub("de:\n", "#{locale}:\n")
  YAML.load(out) # just to make sure the file is valid YAML
  File.open("config/locales/typus.#{locale}.yml", "w+") { |file| file.write(out) }
end