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

task :erb, [:env, :template, :output] do |t, args|
  output = args[:output] || "index.html"
  env = args[:env] || ''
  
  sh "#{env} erb -r ./lib/cv.rb #{args[:template]} > #{output}"
end

task :generate => [:check, :clean, :mkdirs] do
  # execute without invoking dependencies, and immediately reenable
  Rake::Task[:erb].execute :template => 'template/index.html'
end

task :generate_light => [:remove_index, :mkdirs] do
  # execute without invoking dependencies, and immediately reenable
  Rake::Task[:erb].execute :env => 'CV_NO_GRAB=1', :template => 'template/index.html'
end

task :generate_test => [:remove_index, :mkdirs] do
  # first let's replace the placeholder usernmae string
  require 'tempfile'
  tmp = Tempfile.new('index.html')
  sh "sed 's/YOUR_USERNAME/torvalds/' template/example.html > #{tmp.path}"

  # then execute without invoking dependencies, and immediately reenable
  Rake::Task[:erb].execute :env => 'CV_NO_GRAB=1', :template => tmp.path, :output => '/dev/null'

  # and clean up
  File.delete tmp.path
end

task :example => [:check, :clean, :mkdirs] do
  # execute without invoking dependencies, and immediately reenable
  Rake::Task[:erb].execute :template => 'template/example.html'
end

task :example_light => [:remove_index, :mkdirs] do
  # execute without invoking dependencies, and immediately reenable
  Rake::Task[:erb].execute :env => 'CV_NO_GRAB=1', :template => 'template/example.html'
end

task :example_test => [:remove_index, :mkdirs] do
    # execute without invoking dependencies, and immediately reenable
    Rake::Task[:erb].execute :env => 'CV_NO_GRAB=1', :template => 'template/example.html', :output => '/dev/null'
end

task :test => [:example_test, :generate_test] do |t|
  puts "running unit tests..."
  ruby "lib/test.rb"
  puts "done"
end

task :release => [:test, :example]
