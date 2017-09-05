class Post

  attr_accessor :body #define getter and setter of attributes

  def initialize(opts = {})
    @body = opts[:body].to_s
  end


  def nice_print
    puts "\t #{self.body}"
  end

end
