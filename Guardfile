# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'compass' do
  watch(/^sass\/(.*)\.s[ac]ss/)
end

# Add files and commands to this file, like the example:
#   watch('file/path') { `command(s)` }
#
guard 'shell' do
  watch(/(slides|views)\/(.*).haml/) {|m|
    fullpath = m[0]
    unless m[2][0] == "."
      puts "Rebuilding index.html..."
      `rake render`
    end
  }
  watch(/lib\/(.*)rb/) {|m|
    `rake render`
  }
end
