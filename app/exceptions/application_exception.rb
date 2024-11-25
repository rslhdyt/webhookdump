class ApplicationException < StandardError
  attr_reader :code

  def initialize(msg = "Something went wrong", code = 500)
    @code = code

    super(msg)
  end
end