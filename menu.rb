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

def logged_in_menu
  system("clear")
  puts '#'*60
  puts '#'*60
  puts "MINISOCIAL :)".rjust(40, '#') + '#'*20
  puts "WELCOME - #{@current_user.nickname.length <= 0 ?
                    @current_user.email :
                    @current_user.nickname}"
  puts "_"*60
  puts ""
  puts "MENU"
  puts ""
  puts "1. Publique algo mi perrito"
  puts "2. Ver publicaciones"
  puts "3. Cerrar sesion"
  puts "0. Salir"
  puts "-1. Export users to to excel" if @current_user.role == "admin"
end
