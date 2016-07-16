task default: %w[generate]

# alias for generate without download
task :light => [:generate_light]

task :remove_index do
  sh 'rm -f index.html'
end

task :clean => :remove_index do
  sh 'rm -f images/*'
end

task :mkdirs do
  sh 'mkdir -p images'
end

task :check do
  print "checking..."
  # TODO check given URLs
  puts "done"
end

task :erb, [:env, :template] do |t, args|
  sh "#{args[:env]} erb -r ./lib/cv.rb #{args[:template]} > index.html"
end

task :generate => [:check, :clean, :mkdirs] do
  # execute without invoking dependencies, and immediately reenable
  Rake::Task[:erb].execute :env => '', :template => 'template/index.html'
end

task :generate_light => [:remove_index, :mkdirs] do
  # execute without invoking dependencies, and immediately reenable
  Rake::Task[:erb].execute :env => 'CV_NO_GRAB=1', :template => 'template/index.html'
end

task :generate_test => [:remove_index, :mkdirs] do
  # execute without invoking dependencies, and immediately reenable
  Rake::Task[:erb].execute :env => 'CV_NO_GRAB=1', :template => '/dev/null'
end

task :example => [:check, :clean, :mkdirs] do
  # execute without invoking dependencies, and immediately reenable
  Rake::Task[:erb].execute :env => 'CV_EXAMPLE=1', :template => 'template/example.html'
end

task :example_light => [:remove_index, :mkdirs] do
  # execute without invoking dependencies, and immediately reenable
  Rake::Task[:erb].execute :env => 'CV_EXAMPLE=1 CV_NO_GRAB=1', :template => 'template/example.html'
end

task :example_test => [:remove_index, :mkdirs] do
  # execute without invoking dependencies, and immediately reenable
  Rake::Task[:erb].execute :env => 'CV_EXAMPLE=1 CV_NO_GRAB=1', :template => '/dev/null'
end

task :test => [:example_test, :generate_test] do |t|
  puts "running unit tests..."
  ruby "lib/test.rb"
  puts "done"
end

task :release => [:test, :example]
