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
    puts "Normalizing #{path} as text file"
    File.write(normal_path, fixed_content)
    File.delete(normal_path)
    File.rename("#{normal_path}.folded", normal_path)
    File.delete(path) unless path == normal_path
    TextFile.new(normal_path)
  rescue
    File.write(path, content)
  end

  private

  def content
    @content ||= File.read(path)
  end

  def fixed_content
    content
      .lines
      .map{|line| fixed_image_line(line)}
      .map{|line| fixed_pdf_line(line)}
      .join("")
  end

  def fixed_pdf_line(line)
    line.gsub(".pdf", ".txt")
  end

  def fixed_image_line(line)
    regex = /(\({{site\.cdn_url}}\/assets\/images\/([0-9]{4}-[0-9]{2}-[0-9]{2}\/)?.*\))/
    line.gsub(regex) do |match|
      match
        .downcase
        .gsub(" ", "_")
        .gsub(/(-|–)/, "-")
        .gsub("__", "_")
    end
  end

end
