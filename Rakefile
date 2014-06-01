desc "Make a downloadable zip file for release"
task :release do |t|
  all_files = `git ls-files`.split.join " "
  `zip release.zip #{all_files}`
end
