require_relative "project_file"

class Directory
  def initialize(path)
    @path = path
  end

  def normalize!
    path
      .children
      .map{|childpath| ProjectFile.for(childpath) }
      .each(&:normalize!)
  end

  private

  attr_reader :path
end
