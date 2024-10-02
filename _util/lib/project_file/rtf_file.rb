require_relative "project_file"

class RtfFile < ProjectFile
  register(self)

  def self.extensions
    %W(.rtf)
  end

  def self.handles?(target)
    extensions.include?(target.extname.downcase)
  end

  def normalize!
    rtftotext!
    File.delete(path) unless path == normal_path
    TextFile.new(text_file_path).normalize!
  end

  private

  def rtftotext!
    cmd ="unrtf '#{path}' | html2text > '#{text_file_path}'"
    puts "Converting..."
    puts cmd
    system(cmd)
  end

  def text_file_path
    path.to_s.gsub(path.extname, ".txt")
  end

end
