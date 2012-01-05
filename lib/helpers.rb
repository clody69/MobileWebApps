
module PresentationHelper
  
  def example_header_tag(title, name)
    h = "<h1>#{title}"    
  end

  def image_tag(img_path, hsh = {})
    h = ""  
    if not hsh[:nowrap]
      h += "<div class='image-wrap'>"
    end
    
    if not hsh[:caption] and hsh[:url]
       h += "<a href='#{hsh[:url]}'>"
    end
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
    if not hsh[:caption] and hsh[:url]
       h += "</a>"
    end
    
    if hsh[:caption]
      h += "<div class='caption'>"
        if hsh[:url]
          h += "<a href='#{hsh[:url]}'>#{hsh[:caption]}</a></div>"
        else
          h += "#{hsh[:caption]}</div>"
        end
      end
    if not hsh[:nowrap]
      h += "</div>"
    end
    h
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
