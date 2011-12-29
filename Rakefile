require "rake"
$LOAD_PATH <<   File.join(File.dirname(__FILE__), "lib")

desc "Task1"
task :render do
  require "generator"
  include DeckJSBuilder
  build "views/layout.html.haml", "slides.html"
  #build "views/site.html.haml", "index.html"
end

desc "Rebuild SASS/CSS"
task :style do
  require "generator"
  include DeckJSBuilder
  css
end

desc "Synchronize github pages"
task :ghpages do
  `git checkout gh-pages`
  `git rebase master`
  `git push origin gh-pages`
  `git checkout master`
end
