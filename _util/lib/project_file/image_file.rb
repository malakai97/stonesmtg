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
    move(normal_path)
  end

  private

  def normal_path
    Pathname.new(super.to_s.gsub("jpeg", "jpg"))
  end
end

