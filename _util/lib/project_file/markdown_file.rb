require_relative "project_file"

class MarkdownFile < ProjectFile
  register(self)

  def self.extensions
    %W(.md)
  end

  def self.handles?(target)
    extensions.include?(target.extname.downcase)
  end

  def normalize!
    File.write(normal_path, fixed_content)
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
      .map{|line| add_cdn_url_to_assets(line)}
      .map{|line| fixed_pre_image_line(line)}
      .map{|line| fixed_image_line(line)}
      .map{|line| fixed_pdf_line(line)}
      .map{|line| cleanup_double_parens(line)}
      .join("")
  end

  def fixed_pdf_line(line)
    line.gsub(".pdf", ".txt")
  end

  def add_cdn_url_to_assets(line)
    return line if line =~ /^cover/

    line.gsub(/\(\/?assets\/images\/.+$/) do |match|
      # Here we drop the parenthesis and the optional slash so we can
      # add them back later
      fixed_match = if match[1] == "/"
        match[2, match.size]
      else
        match[1, match.size]
      end
      "({{site.cdn_url}}/#{fixed_match})"
    end
  end

  def fixed_pre_image_line(line)
    line.sub(/^\(\//, "![](/")
  end

  def fixed_image_line(line)
    regex = /(\({{site\.cdn_url}}\/assets\/images\/([0-9]{4}-[0-9]{2}-[0-9]{2}\/)?.*\))/
    line.gsub(regex) do |match|
      match
        .downcase
        .gsub(" ", "_")
        .gsub(/(-|–)/, "-")
        .gsub("__", "_")
        .gsub(/\.(png|heic|jpeg)/, ".jpg")
    end
  end

  def cleanup_double_parens(line)
    line
      .gsub("((", "(")
      .gsub("))", ")")
  end

end
