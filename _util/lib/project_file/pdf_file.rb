require_relative "project_file"
require_relative "text_file"

class PdfFile < ProjectFile
  register(self)

  def self.extensions
    %W(.pdf)
  end

  def self.handles?(target)
    extensions.include?(target.extname.downcase)
  end

  def normalize!
    pdftotext!
    File.delete(path) unless path == normal_path
    TextFile.new(text_file_path).normalize!
  end

  private

  def pdftotext!
    cmd ="pdftotext '#{path}' '#{text_file_path}'"
    puts "Converting..."
    puts cmd
    system(cmd)
  end

  def text_file_path
    path.to_s.gsub(path.extname, ".txt")
  end

end
