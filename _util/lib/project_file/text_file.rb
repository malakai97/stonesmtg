require_relative "project_file"

class TextFile < ProjectFile
  register(self)

  def self.extensions
    %W(.md .txt)
  end

  def self.handles?(target)
    extensions.include?(target.extname.downcase)
  end

  def normalize!
    File.write(normal_path, fixed_content)
    File.delete(path) unless path == normal_path
    TextFile.new(normal_path)
  end

  private

  # TODO the issue with fold is that it doesn't care about image lines, and thus
  #   breaks them.
  def folded_content
    `fold -s #{path}`
  end

  def content
    @content ||= File.read(path)
  end

  def fixed_content
    content
      .lines
      .map{|line| fixed_image_line(line)}
      .join("")
  end

  def fixed_image_line(line)
    regex = /(\(\/assets\/images\/([0-9]{4}-[0-9]{2}-[0-9]{2}\/)?.*\))/
    line.gsub(regex) do |match|
      match
        .downcase
        .gsub(" ", "_")
        .gsub(/(-|–)/, "-")
        .gsub("__", "_")
    end
  end

end
