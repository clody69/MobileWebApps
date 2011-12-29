
module PresentationHelper
  def render_slide(name)
    content = render "slides/#{name}.html.haml"
    if File.exist?('imgs/bg-' + name + '.jpg')
      content.gsub!(/<section class='slide/,"<section data-background='bg-#{name}' class='slide")
    end
    content
  end
  def image_tag_with_caption(img_path, hsh = {})
    h = "<div class='image-wrap'>"
    h += "<img src='imgs/#{img_path}' "
    
    if hsh[:resize]
      h += "class='resize' "
    end
    if hsh[:width]
      h += "width=#{hsh[:width]} "
    end  
    if hsh[:height]
      h += "height=#{hsh[:height]} "
    end  
    h+= "/>"
    
    if hsh[:caption]
      h += "<div class='caption'>"
        if hsh[:url]
          h += "<a href='#{hsh[:url]}'>#{hsh[:caption]}</a></div>"
        else
          h += "#{hsh[:caption]}</div>"
        end
      end
    h += "</div>"
  end
  def pygmentize(lexer,&block)
    text = capture_haml do
      yield
    end
    require "digest"
    filename = ".pygments-cache/" + Digest::MD5.hexdigest(text) + ".txt"
    if File.exists? filename
      puts "loading syntax hl from cache"
      return IO.read(filename)
    end

    pygmentize = IO.popen("pygmentize -f html -l #{lexer}", "w+")
    pygmentize.puts text
    pygmentize.close_write
    result = pygmentize.gets(nil)
    pygmentize.close

    FileUtils.mkdir_p(".pygments-cache")
    File.open(filename,"w+") {|f| f.write(result)}
    result
  end

end
