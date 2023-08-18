require_relative "project_file"

class HeicFile < ProjectFile
  register(self)

  def self.extensions
    %W(.heic)
  end

  def self.handles?(target)
    extensions.include?(target.extname.downcase)
  end

  def normalize!
    move(normal_path)
    `heif-convert #{normal_path} #{normal_path.to_s.gsub("heic", "jpg")}`
    FileUtils.rm(normal_path)
  end

end

