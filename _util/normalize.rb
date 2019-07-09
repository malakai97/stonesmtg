def rename(file)
  new_name = file
    .downcase
    .gsub(" ", "_")
    .gsub("-_", "")
  File.rename(file, new_name)
  new_name
end

def fixed_content(content)
  content
    .lines
    .map{|line| fixed_image_line(line)}
    .join("")
end

def fixed_image_line(line)
  regex = /(\(\/assets\/images\/[0-9]{4}-[0-9]{2}-[0-9]{2}\/.*\))/
  line.gsub(regex) do |match|
    match
      .downcase
      .gsub(" ", "_")
      .gsub(/(-|–)/, "")
      .gsub("__", "_")
  end
end

file = ARGV.first
file = rename(file)

File.write(file, fixed_content(File.read(file)))

