require 'faker'

namespace :dev do
  desc "Reset the database"
  task reset: :environment do
    system("rails db:drop")
    system("rails db:create")
    system("rails db:migrate")
    system("rails db:seed")
    system("rails dev:add_room_types")
    system("rails dev:add_amenities")
    system("rails dev:add_cancellation_reasons")
    system("rails dev:add_hotels_and_rooms")
  end

  desc "Add room_types to the database"
  task add_room_types: :environment do
    show_spinner("Adding room_types to the database") { add_room_types }
  end

  desc "Add amenities to the database"
  task add_amenities: :environment do
    show_spinner("Adding amenities to the database") { add_amenities }
  end

  desc "Add cancellation_reasons to the database"
  task add_cancellation_reasons: :environment do
    show_spinner("Adding cancellation_reasons to the database") { add_cancellation_reasons }
  end

  desc "Add hotels and rooms to the databas"
  task add_hotels_and_rooms: :environment do
    show_spinner("Adding hotels and rooms to the database") { add_hotels_and_rooms }
  end

  def add_room_types
    [ "Standard", "DeLuxe", "Executivo", "Suite Executiva", "Suite Presidencial",
      "Econômico", "Studio", "Single", "Premium" ].each do |name|
      RoomType.create!(
        description: name
      )
    end
  end

  def add_amenities
    [ "Wi-Fi gratuito", "Estacionamento gratuito", "Piscina", "Academia", "Café da manhã incluso",
      "Serviço de quarto", "Ar-condicionado", "Transfer aeroporto/hotel", "Restaurante no local",
      "Bar/Lounge", "Recepção 24 horas", "Acessibilidade para pessoas com deficiência",
      "Serviço de lavanderia", "Pet-friendly (aceita animais de estimação)", "Spa",
      "Salas de reunião/eventos", "Serviço de concierge", "Minibar", "Televisão a cabo/satélite",
      "Área de lazer infantil", "Quadra de esportes", "Salão de Jogos"].each do |name|
      Amenity.create!(
        description: name
      )
    end
  end

  def add_cancellation_reasons
    cancellation_reasons = [
      { name: 'Mudança de planos', description: 'Cliente mudou seus planos de viagem' },
      { name: 'Problemas pessoais', description: 'Motivos pessoais ou familiares' },
      { name: 'Encontrou melhor opção', description: 'Cliente encontrou alternativa mais adequada' },
      { name: 'Problemas financeiros', description: 'Questões financeiras impediram a continuidade' },
      { name: 'Erro na reserva', description: 'Reserva feita com informações incorretas' },
      { name: 'Outros', description: 'Outros motivos não listados' }
    ]
    cancellation_reasons.each do |reason|
      CancellationReason.create!(
          name: reason[:name],
          description: reason[:description]
        )
    end
  end

  def add_hotels_and_rooms
    # Configurando Faker para usar localização brasileira
    Faker::Config.locale = 'pt-BR'

    titles = [  "Localização perfeita para explorar a cidade.",
                "Um refúgio de luxo com vista para o mar.",
                "Ideal para viagens de negócios e lazer.",
                "Charme e conforto no coração da cidade.",
                "Para uma estadia relaxante perto da natureza.",
                "A poucos passos das principais atrações turísticas.",
                "Conforto moderno em uma localização histórica.",
                "Refúgio tranquilo perto das praias.",
                "Perfeito para famílias e grupos.",
                "Estadia acessível com qualidade superior.",
                "Vista panorâmica de tirar o fôlego.",
                "Oásis de tranquilidade em meio ao centro urbano.",
                "Localizado ao lado de lojas e restaurantes.",
                "Hotel boutique com design contemporâneo.",
                "Sofisticação e conforto no centro da cidade.",
                "Conveniência e praticidade ao lado do aeroporto.",
                "A apenas alguns minutos da praia.",
                "Estadia ideal para eventos e reuniões.",
                "Atmosfera acolhedora com toque moderno.",
                "Ótima opção para estadias prolongadas.",
                "Experiência única com vista espetacular.",
                "Um refúgio romântico para casais.",
                "Elegância e conforto à beira-mar.",
                "Perfeito para quem busca aventura e relaxamento.",
                "Localização central com fácil acesso ao transporte público.",
                "Hotel moderno com instalações de lazer.",
                "O melhor custo-benefício na área.",
                "Ambientes aconchegantes e atendimento personalizado.",
                "No coração da vida noturna e cultural da cidade.",
                "Hotel sofisticado com restaurante premiado.",
                "Experiência de luxo em um local exclusivo.",
                "A escolha perfeita para viajantes a negócios.",
                "Conforto e conveniência em um só lugar.",
                "Vista privilegiada de pontos turísticos icônicos.",
                "Ideal para explorar os arredores culturais.",
                "Hotel familiar com atrações próximas.",
                "Modernidade e tradição em harmonia.",
                "Localização ideal para descobrir a cidade histórica.",
                "Perto de parques e áreas de recreação.",
                "Estilo contemporâneo em uma localização vibrante.",
                "Perfeito para quem busca descanso e tranquilidade.",
                "Experiência única em uma cidade encantadora.",
                "Luxo discreto e serviço impecável.",
                "Para uma estadia inesquecível à beira-mar.",
                "Estadia econômica com excelente localização.",
                "Perfeito para escapadas de fim de semana.",
                "Comodidade e estilo no centro comercial.",
                "Espaços amplos e serviço de qualidade.",
                "Desfrute de uma estadia tranquila em meio à natureza.",
                "Conforto e sofisticação para todos os perfis de viajantes."
              ]

    names = [ "Hotel Paradise", "Sunset Resort", "Mountain View Inn", "Ocean Breeze Lodge",
              "Tranquil Haven", "Golden Sands Hotel", "Forest Retreat", "Crystal Bay Resort",
              "Skyline Suites", "Riverfront Lodge", "Harbor View Inn", "Serenity Springs",
              "Emerald Hills Hotel", "Coastal Cove Resort", "Starlight Suites", "Valley View Lodge",
              "Blue Lagoon Inn", "Whispering Pines Resort", "Silver Beach Hotel", "Mountain Peak Inn",
              "Seaside Retreat", "Lakeside Lodge", "Sunrise Resort", "Moonlight Inn", "Green Valley Hotel",
              "Golden Gate Lodge", "Crystal Cove Resort", "Pine Ridge Inn", "Ocean View Suites",
              "Mountain Lodge", "Harbor Inn", "Sapphire Springs", "Coastal Haven", "Starfish Resort",
              "Valley Inn", "Blue Sky Lodge", "Whispering Waves Hotel", "Silver Lake Resort",
              "Mountain View Suites", "Seabreeze Inn", "Lakeshore Lodge", "Sunset Haven",
              "Moonstone Hotel", "Greenwood Resort", "Golden Pine Inn", "Crystal Lake Lodge",
              "Pineapple Cove", "Oceanfront Suites", "Mountain Ridge Hotel"
            ]

    # Embaralha os arrays para garantir aleatoriedade
    names.shuffle!
    titles.shuffle!

    50.times do |i|
      break if names.empty? || titles.empty?

      floors = rand(2..4)
      max_rooms_per_floor = rand(3..5)
      total_rooms = floors * max_rooms_per_floor

      hotel = Hotel.create!(
        name: names.pop,
        location: "#{Faker::Address.latitude}, #{Faker::Address.longitude}",
        email: Faker::Internet.email,
        telephone: Faker::PhoneNumber.phone_number.gsub(/\+\d+\s/, ''),
        title: titles.pop,
        description: "Bem-vindo ao Smith Enterprises, um hotel de luxo em Rio de Janeiro, Brazil.
                      Localizado no coração da cidade, oferecemos quartos elegantes e serviços de primeira classe.
                      Aproveite nossos atrativos exclusivos como piscina infinita, quartos com decoração exclusiva, etc.
                      Descubra o que torna o Smith Enterprises um dos melhores hotéis de luxo do mundo.",
        total_rooms: total_rooms ,
        floors: floors,
        max_rooms_per_floor: max_rooms_per_floor,
        address_zip_code: Faker::Address.zip_code,
        address_state: Faker::Address.state_abbr,
        address_city: Faker::Address.city,
        address_neighborhood: Faker::Address.community,
        address_street: Faker::Address.street_name,
        address_number: Faker::Address.building_number,
        address_complement: "",
        amenity_ids: Amenity.pluck(:id).sample(rand(6..10))
      )

      create_rooms(hotel)
    end
  end

  def create_rooms(hotel)
    room_features = [
      "Cama King", "Mesa de cabeceira", "Luminária de leitura", "Guarda-roupa",
      "TV de tela plana", "Telefone de mesa", "Cofre", "Ar-condicionado",
      "Cortinas blackout", "Sauna", "Internet"
    ]

    room_count = 0
    (1..hotel.floors).each do |floor|
      (1..hotel.max_rooms_per_floor).each do |room_number|
        break if room_count >= hotel.total_rooms
        formatted_room_number = sprintf("%02d", room_number)
        full_room_number = "#{floor}#{formatted_room_number}"

        Room.create!(
          room_number: full_room_number,
          floor_number: floor,
          description: room_features.sample(8).join(", "),
          status: "available",
          daily_price: Money.from_amount(rand(100.0..1000.0).round(2)),
          hotel: hotel,
          room_type: RoomType.all.sample
        )

        room_count += 1
      end
    end
  end

  def show_spinner(msg_start, msg_end = "Done!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end

end
