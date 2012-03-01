require "haml"
require "yaml"
require "helpers"
require "haml-coderay"
require "coderay"

Haml::Filters::CodeRay.encoder_options = {:css => :class}

module DeckJSBuilder
  MAIN_DIR = File.join File.dirname(__FILE__), ".."

  include PresentationHelper
  META = YAML.load_file File.join(MAIN_DIR, "meta.yml")
  title = 'ciao'
  
  def render(file, layout='', b=binding)
    file = File.join MAIN_DIR, file
    
    content = Haml::Engine.new(IO.read(file), :ugly => true).render(b)
    
    #name = File.basename(file,'.html.haml')
    #if File.exist?( File.join(Dir.pwd, '../public/imgs/bg-' + name + '.jpg'))
    #  content.gsub!(/<section class='slide/,"<section data-background='bg-#{name}' class='slide")
    #  content.gsub!(/bg-default/,"bg-#{name}")
    #end
    
    if layout != ''
      layout = File.join MAIN_DIR, layout
      Haml::Engine.new(IO.read(layout), :ugly => true).render(b,{}) {
      content
      }
    else
      content
    end
  end
  
  def build(file, layout, output="")

    puts "[#{Time.now.strftime("%H:%M:%S")}] Compiling #{file}"
    text = render file, layout, binding
    if output == ""
      write_to = File.join MAIN_DIR, file.sub('.haml','')     
    else
      write_to = File.join MAIN_DIR, output     
    end
    
    File.open(write_to,"w+") {|f| f.write text}
    puts "[#{Time.now.strftime("%H:%M:%S")}] written #{write_to}"
  end

  def css
    puts `bundle exec compass compile #{MAIN_DIR} 2>&1`
  end

  def print_coderay_css(file)
    write_to = File.join MAIN_DIR, file
    File.open(write_to, "w+") {|f| f.write CodeRay::Encoders[:html]::CSS.new.stylesheet}
  end
end

