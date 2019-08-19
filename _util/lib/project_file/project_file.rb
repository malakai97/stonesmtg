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


