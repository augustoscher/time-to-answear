namespace :dev do
  desc "Setup development environment"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Dropping database...") do
        %x(rails db:drop)
      end
      show_spinner("Creating database...") { %x(rails db:create) }        
      show_spinner("Migrating database...") { %x(rails db:migrate) }
      show_spinner("Initializing database...") { %x(rails db:seed) }
      
      #Precisa ser em ordem
      %x(rails dev:add_admins)
      %x(rails dev:add_users)
    else 
      puts "You're not in development"
    end
  end

  desc "Adding Default Admins"
  task add_admins: :environment do
    show_spinner("Adding Default Admins...") do
      admins = [ 
              { email: "admin@admin.com.br", password: "123456", password_confirmation: "123456" }
            ]

      admins.each do |admin| 
        Admin.create!(admin)
      end 
    end
  end

  desc "Adding Default User"
  task add_users: :environment do
    show_spinner("Adding Default User...") do
      users = [ 
              { email: "user@user.com.br", password: "abcdef", password_confirmation: "abcdef" }
            ]

      users.each do |user| 
        User.create!(user)
      end 
    end
  end

  private 
    def show_spinner(msg_init, msg_end=:Finished!)
      spinner = TTY::Spinner.new("[:spinner] #{msg_init}")
      spinner.auto_spin
      #esse comando executa o comando passado pelo bloco do end/{}
      yield
      spinner.success("(#{msg_end})")
    end
  end

