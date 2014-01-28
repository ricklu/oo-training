class Logger
  attr_reader :content
  def initialize
    @content = ''
  end

  def puts(content)
    @content += content
  end
end