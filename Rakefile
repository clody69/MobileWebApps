require "rake"
$LOAD_PATH <<   File.join(File.dirname(__FILE__), "lib")

desc "Task1"
task :render do
  require "generator"
  include DeckJSBuilder
  #build "site/views/slides.html.haml", "site/layout/slides.html.haml", "public/slides.html"
  build "site/views/site.html.haml", "site/layout/site.html.haml", "public/index.html"
  build "site/views/site_preview.html.haml", "site/layout/site.html.haml", "public/site.html"
  build "site/views/notes.html.haml", "site/layout/site.html.haml", "public/notes.html"

  Dir["site/examples/*.html.haml"].each { |file| build file, "site/layout/site.html.haml", "public/" + File.basename(file).gsub('.haml','')}

  Dir["site/slides/*.html.haml"].each { |file| build file, "site/layout/slides.html.haml", "public/" + File.basename(file).gsub('.haml','')}

  print_coderay_css "public/css/coderay.css"

  %w(jQuerySimple senchaSimple websocketsEcho deviceGeolocation deviceOrientation).each { |file| 
    dst = "public/examples/#{file}"
    FileUtils.mkdir_p(dst)
    FileUtils.cp_r Dir.glob("../examples/#{file}/*.html"), dst
    FileUtils.cp_r Dir.glob("../examples/#{file}/*.css"), dst
    FileUtils.cp_r Dir.glob("../examples/#{file}/*.js"), dst
  }

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
