require_relative "project_file"

class TextFile < ProjectFile
  register(self)

  def self.extensions
    %W(.txt)
  end

  def self.handles?(target)
    extensions.include?(target.extname.downcase)
  end

  def normalize!
    move(normal_path)
  end

end
