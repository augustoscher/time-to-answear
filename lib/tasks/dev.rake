namespace :dev do

  DEFAULT_FILE_PATH = File.join(Rails.root, 'lib', 'tmp')

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
      %x(rails dev:add_subjects)
      %x(rails dev:add_questions)
      %x(rails dev:reset_subject_counter)
    else 
      puts "You're not in development"
    end
  end

  desc "Adding Admins"
  task add_admins: :environment do
    show_spinner("Adding Admins...") do
      admins = []
      admins.push({ email: "admin@admin.com.br", password: "123456", password_confirmation: "123456" })

      3.times do
        admins.push({ email: Faker::Internet.email, password: "123456", password_confirmation: "123456" })
      end

      admins.each do |admin| 
        Admin.create!(admin)
      end 
    end
  end

  desc "Adding Users"
  task add_users: :environment do
    show_spinner("Adding User...") do
      users = []
      users.push({ email: "user@user.com.br", password: "abcdef", password_confirmation: "abcdef" })
      
      5.times do 
        users.push({ email: Faker::Internet.email, password: "abcdef", password_confirmation: "abcdef" })
      end

      users.each do |user| 
        User.create!(user)
      end 
    end
  end

  desc "Adding Subjects"
  task add_subjects: :environment do
    show_spinner("Adding Subjetcs...") do
      file = File.open("#{DEFAULT_FILE_PATH}/subjects.txt")
      file.each do |line|
        Subject.create!({description: line.strip})
      end
    end
  end

  desc "Adding Questions"
  task add_questions: :environment do
    show_spinner("Adding Questions...") do
      Subject.all.each do |subject|
        rand(5..10).times do |i| 
          params = create_question_params
          answers_array = params[:question][:answers_attributes]

          add_answers(answers_array)
          set_true_answer(answers_array)

          Question.create!(params[:question])
        end
      end
    end
  end

  desc "Reset subject counter"
  task reset_subject_counter: :environment do
    show_spinner("Reseting subject counter...") do
      Subject.all.each do |subject|
        Subject.reset_counters(subject.id, :questions)
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

    def create_question_params(subject = Subject.all.sample)
      { question: {
        description: "#{Faker::Lorem.paragraph} #{Faker::Lorem.question}",
        subject: subject,
        answers_attributes: []
      }}
    end

    def create_answer(isCorrect = false)
      {description: "#{Faker::Lorem.sentence}", correct: isCorrect }
    end

    def add_answers(answers_array = [])
      rand(2..5).times do |j|
        answers_array.push(create_answer(false))
      end
    end

    def set_true_answer(answers_array = [])
      index_random_answer = rand(answers_array.size)
      answers_array[index_random_answer] = create_answer(true)
    end
  end

