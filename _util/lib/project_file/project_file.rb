require "fileutils"

class ProjectFile

  def self.for(target)
    registry.find {|candidate| candidate.handles?(target) }
      .new(target)
  end

  def self.registry
    @@registry ||= []
  end

  def self.register(candidate)
    registry.unshift(candidate)
  end

  def self.handles?(_target)
    true
  end

  register(self)

  def initialize(path)
    @path = path
  end

  def normalize!
    true
  end

  def move(new_path)
    unless path == new_path
      puts "#{path} -> #{new_path}"
      FileUtils.move(path, "#{path}t")
      FileUtils.move("#{path}t", new_path)
    end
    self.class.new(new_path)
  end

  private

  attr_reader :path

  def normal_path
    Pathname.new(
      path
      .to_s
      .downcase
      .gsub(" ", "_")
      .gsub("-_", "")
    )
  end
end


