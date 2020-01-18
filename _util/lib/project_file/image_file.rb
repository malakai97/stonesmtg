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
    File.rename(path, jpg_path(normal_path))
    self.class.new(normal_path)
  end

  private

  # deal with .jpeg
  def jpg_path(path)
    Pathname.new(
      path
      .to_s
      .gsub("jpeg", "jpg")
    )
  end
end

