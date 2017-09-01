class Post

  attr_accessor :body

  def initialize(opts = {})
    @body = opts[:body].to_s
  end

end


class User

  PSW_REGEX = /\A.{8}\z/
  EMAIL_REGEX = /\A\p{Alnum}+@\p{Alnum}+\.com\z/
  attr_accessor :email, :password, :nickname, :posts

  def initialize(opts = {})
    #@email = opts[:email] ? opts[:email] : raise(Exception.new("PailaMiPerro"))
    @email = opts[:email].to_s
              .scan(EMAIL_REGEX).any? ?
              opts[:email] :
              abort("PailaMiPerro eso no es un email")
    @password = opts[:password].to_s.scan(PSW_REGEX).any? ? opts[:password] : abort("PailaMiPerro eso no es un password valido")
    @nickname = opts[:nickname].to_s
    @posts = opts[:posts].is_a?(Array) ? opts[:posts] : []
  end

  # crea un Post y lo agrega al arreglo de posts
  # parameters: opts = {}. opts[:body], recibe el body del post en un hash.
  def create_post(opts = {})
    self.posts << Post.new(opts)
  end

  def authenticate(password_submitted)
    self.password == password_submitted.to_s
  end

end

# user = User.new(
#   email: "yonga@fusepong.com",
#   password: "holaqueh",
#   nickname: "yonga"
# )
# user2 = User.new(
#   email: "camilo@fusepong.com",
#   password: "12345678",
#   nickname: "camilo"
# )
#
# user.create_post(body: "hola que hace, banderiando o que hace??")
# puts user.posts.inspect
# puts user.posts.first
# puts user.posts.first.class
# puts user.posts.first.inspect
# puts user.posts.first.body
#
# puts "authenticate #{user.nickname} with 12345678"
# puts user.authenticate "12345678"
# puts "authenticate #{user2.nickname} with 12345678"
# puts user2.authenticate "12345678"


def menu
  system("clear")
  puts '#'*60
  puts '#'*60
  puts "MINISOCIAL :)".rjust(40, '#') + '#'*20
  puts "WELCOME".rjust(35, '#') + '#'*25
  puts "_"*60
  puts ""
  puts "MENU"
  puts ""
  puts "1. Registrarse"
  puts "2. Iniciar sesion"
  puts "0. Salir"
end

def sign_up
  puts "Dijite su correo electronico."
  email = gets.chomp
  puts "Dijite su password."
  password = gets.chomp
  puts "Confirme su password."
  password_confirmation = gets.chomp
end

@input = nil
while @input != 0 do
  menu
  @input = gets.chomp.to_i
end





























#
