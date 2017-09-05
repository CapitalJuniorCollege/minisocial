class User

  PSW_REGEX = /\A.{8}\z/
  EMAIL_REGEX = /\A\p{Alnum}+@\p{Alnum}+\.com\z/
  attr_accessor :email, :password, :nickname, :posts
  attr_reader :role

  def initialize(opts = {})
    #@email = opts[:email] ? opts[:email] : raise(Exception.new("PailaMiPerro"))
    @email = opts[:email].to_s
              .scan(EMAIL_REGEX).any? ?
              opts[:email] :
              abort("PailaMiPerro eso no es un email #{opts[:email]}")
    @password = opts[:password].to_s.scan(PSW_REGEX).any? ? opts[:password] : abort("PailaMiPerro eso no es un password valido")
    @nickname = opts[:nickname].to_s
    @posts = opts[:posts].is_a?(Array) ? opts[:posts] : []
    @role = @email == "yonga@email.com" ? "admin" : "user"
  end

  # crea un Post y lo agrega al arreglo de posts
  # parameters: opts = {}. opts[:body], recibe el body del post en un hash.
  def create_post(opts = {})
    self.posts << Post.new(opts)
  end

  def authenticate(password_submitted)
    self.password == password_submitted.to_s
  end

  def nice_print_posts
    puts "-- #{self.email} --"
    self.posts.each do |post|
      post.nice_print
    end
    puts ""
  end

end
