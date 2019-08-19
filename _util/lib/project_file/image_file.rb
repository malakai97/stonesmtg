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
    File.rename(path, normal_path)
    ImageFile.new(normal_path)
  end
end

