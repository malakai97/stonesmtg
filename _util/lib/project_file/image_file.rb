require_relative "project_file"

class ImageFile < ProjectFile
  register(self)

  def self.extensions
    %W(.png .jpg .jpeg .gif)
  end

  def self.handles?(target)
    extensions.include?(target.extname.downcase)
  end

  def normalize!
    new_path = normal_path.to_s.gsub(path.extname, ".jpg")
    cmd = "convert -resize 1600x1200\\> -quality 0.9 '#{path}' '#{new_path}'"
    puts "Converting..."
    puts cmd
    system(cmd)
    FileUtils.rm(path)
  end

end

