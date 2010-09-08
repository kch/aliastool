def macruby_compile(in_files, out_file, flags = "")
  system %[
    cd src &&
    macrubyc -o #{out_file} --arch i386 --arch x86_64 #{flags} #{in_files.join(' ')} &&
    mv #{out_file} ..
  ]
end

IN_FILES = %w( aliastool.rb alias.rb hex_string.rb raisins.rb )
OUT_FILE = "aliastool"

task :default => :build

desc "Clean up"
task :clean do
  system "rm -f src/*.o"
end

desc "Build aliastool"
task :build do
  macruby_compile(IN_FILES, OUT_FILE)
  Rake::Task["clean"].invoke
end

desc "Build aliastool with static MacRuby"
namespace :build do
  task :static do
    macruby_compile(IN_FILES, OUT_FILE, "--static")
    Rake::Task["clean"].invoke
  end
end
