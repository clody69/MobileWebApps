
module PresentationHelper
  
  def lecture_title_tag(title, lecture)
    "<h2>#{title} (<a href='#{lecture}.html'>Slides</a>)</h2>"
  end
  def title_slide_tag(subtitle)
    Haml::Engine.new(IO.read('site/views/title_slide.html.haml'), :ugly => true).render(Object.new,{:subtitle => subtitle}) 
  end

  def html5_offline_storage_tag(title="Offline Storage")
    "<img src = 'imgs/html5/HTML5_Offline_Storage_64.png'>#{title}</img>"
  end

  def html5_device_access_tag(title="Device Access")
    "<img src = 'imgs/html5/HTML5_Device_Access_64.png'>#{title}</img>"
  end
  
  def html5_semantics_tag(title="New Semantics")
    h= '<img src = "imgs/html5/HTML5_Semantics_64.png">'
    h += title
    h += '</img>'
  end
  def html5_websockets_tag(title="WebSockets")
    h= '<img src = "imgs/html5/HTML5_Connectivity_64.png">'
    h += title
    h += '</img>'
  end
  def example_url_tag(name)
    "<a href='#{name}.html'>#{name}</a>"
  end
  
  def render_examples_list
    h = '<ul>'
    Dir["site/examples/*.html.haml"].each { |file| 
      name = File.basename(file).gsub(/.html.haml/,'')
      h += "<li>#{example_url_tag(name)}</li>"
    }
    h += '</ul>'
  end

  def example_header_tag(title, name, url="")
    if url == ""
      if File.directory?("../public/examples/#{name}")
        url = "examples/#{name}"
      end
    end
    
    h = "<h1>#{title}</h1>"  
    h += "<div class='actions'>"
    if url != ""
      h += "<a href='#{url}'>Try it</a>"
    end
    
    h += "<a href='https://github.com/clody69/MobileWebAppsExamples/tree/master/#{name}'>Browse Source Code</a>"
    h += "</div>"
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
