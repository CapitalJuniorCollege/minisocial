require 'faker'
require './post'
require './user'
require './menu'

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

def sign_up
  system "clear"
  puts "Digite su correo electronico."
  email = gets.chomp
  puts "Digite su password."
  password = gets.chomp
  puts "Confirme su password."
  password_confirmation = gets.chomp
  puts "Digite su nickname."
  nickname = gets.chomp
  if password != password_confirmation
    system "clear"
    puts "Password no concide con la confirmacion, intentelo de nuevo, perrito. Presione cualquier tecla para continuar..."
    gets.chomp
    sign_up
    return
  end
  if @users[email]
    system "clear"
    puts "Ya se encuentra un usuario registrado con este email. Crea una cuenta nueva. Presione cualquier tecla para continuar..."
    gets.chomp
    sign_up
    return
  end
  @users[email] = User.new(email: email, password: password, nickname: nickname)
  @current_user = @users[email]
end

def sign_in
  system "clear"
  puts "Digite su correo electronico."
  email = gets.chomp
  puts "Digite su password"
  password  = gets.chomp
  if @users[email] and @users[email].authenticate(password)
    @current_user = @users[email]
  else
    system "clear"
    puts "email o el password incorrecto. Intente de nuevo, presione cualquier tecla para continuar..."
    gets.chomp
    return
  end
end

def logout
  system "clear"
  puts "BYE BYE BYE !!!! Presione, cualquier tecla para continuar..."
  gets.chomp
  @current_user = nil
  return
end

def publish
  system "clear"
  puts "Escriba a ver...."
  body = gets.chomp
  if body.length <= 0
    system "clear"
    puts "Tu publicacion debe tener contenido!!!!!. Presiona cualquier tecla para continuar"
    gets.chomp
    publish
    return
  end
  @current_user.create_post(body: body)
  puts "Le quedo linda la pendejada."
  gets.chomp
end

def feed
  system "clear"
  puts "FEED "
  puts ""
  @users.each do |email,user|
    user.nice_print_posts
  end
  puts "Presione cualquier tecla para continuar..."
  gets.chomp
end

@input = nil
@users = {}
@users["yonga@email.com"] = User.new(
email: "yonga@email.com",
password: "password",
nickname: "yonga"
)
@current_user = nil

def loading_screen
  @thread ||= Thread.new do
    while @users.keys.length < 900 do
      system "clear" and print "#{('#'*(@users.keys.length/50).to_i)}#{('-'*((1000-@users.keys.length)/50).to_i)}"
    end
    puts "almost done.. wait please"
  end
end

def create_user(opts = {})
  @users[opts[:email]] ? nil : @users[opts[:email]] = User.new(opts)
end

def seed
  Thread.new do
    1000.times do |i|
      aux_user = nil
      while !aux_user do
        aux_user = create_user(
        email: Faker::Internet.free_email(Faker::Name.unique.name.split(' ').first.gsub(/\W/,'')).downcase,
        password: Faker::Internet.password(8,8),
        nickname: Faker::Name.first_name.downcase,
        posts: (0...1000).to_a.map{|x| Post.new(body: Faker::ChuckNorris.fact)}
        )
        #loading_screen
      end
    end
  end
end

seed

while @input != 0 do
  if @current_user
    logged_in_menu
    case @input
    when 1 then publish
    when 2 then feed
    when 3 then logout
    end
  else
    menu
    case @input
    when 1 then sign_up
    when 2 then sign_in
    end
  end
  @current_user ? logged_in_menu : menu
  @input = gets.chomp.to_i
end
#
