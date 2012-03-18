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
  build "site/views/lectures.html.haml", "site/layout/site.html.haml", "public/lectures.html"
  build "site/views/examples.html.haml", "site/layout/site.html.haml", "public/examples.html"
  build "site/views/resources.html.haml", "site/layout/site.html.haml", "public/resources.html"

  Dir["site/examples/*.html.haml"].each { |file| build file, "site/layout/site.html.haml", "public/" + File.basename(file).gsub('.haml','')}

  Dir["site/slides/*.html.haml"].each { |file| build file, "site/layout/slides.html.haml", "public/" + File.basename(file).gsub('.haml','')}

  print_coderay_css "public/css/coderay.css"
  
  %w(jQuerySimple senchaSimple websocketsEcho deviceGeolocation deviceOrientation cssMediaQueriesViewport 
    cssMediaQueriesDevice canvasTouch).each { |file| 
    dst = "public/examples/#{file}"
    FileUtils.mkdir_p(dst)
    FileUtils.cp_r Dir.glob("../examples/#{file}/*.html"), dst
    FileUtils.cp_r Dir.glob("../examples/#{file}/*.css"), dst
    FileUtils.cp_r Dir.glob("../examples/#{file}/*.js"), dst
    FileUtils.cp_r Dir.glob("../examples/#{file}/*.jpg"), dst
    FileUtils.cp_r Dir.glob("../examples/#{file}/*.png"), dst
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

#This task is used for generating the pdf file of one html page
#It's using the wkpdf gem that works on ruby 1.8 with the cocoa integration
#We must run it using the system ruby with rvm
#It's also using the too pdftk for merging the pdf files into one
desc "Generate PDF of one slide file"
task :toPDF, [:slide, :pages] do |t, args|
  puts "First name is #{args.slide}"
  system 'mkdir tmp_pdf'
  0.upto(args.pages.to_i-1) do |i|
    system "rvm system exec wkpdf --source 'file://localhost#{Dir.pwd}/../public/#{args.slide}.html#slide-#{i}' --orientation landscape --paper b4 --margins 0 --output tmp_pdf/#{args.slide}-#{ '%05d' % i}.pdf" 
  end
  system "pdftk tmp_pdf/*.pdf cat output ../public/docs/#{args.slide}.pdf"
  system 'rm -rf tmp_pdf'
  #system 'rm -rf tmp_pdf'
end
  
