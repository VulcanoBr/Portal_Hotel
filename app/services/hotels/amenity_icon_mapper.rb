module Hotels
  class AmenityIconMapper
    def self.icon_for(amenity)
      icons = {
        "Wi-Fi gratuito" => "bi-wifi",
        "Estacionamento gratuito" => "bi-car-front-fill",
        "Piscina" => "bi-water",
        "Academia" => "bi-heart-pulse-fill",
        "Café da manhã incluso" => "bi-cup-hot-fill",
        "Serviço de quarto" => "bi-house-door-fill",
        "Ar-condicionado" => "bi-snow2",
        "Transfer aeroporto/hotel" => "bi-airplane-fill",
        "Restaurante no local" => "bi-shop",
        "Bar/Lounge" => "bi-cup-straw",
        "Recepção 24 horas" => "bi-door-open-fill",
        "Acessibilidade para pessoas com deficiência" => "bi-person-wheelchair",
        "Serviço de lavanderia" => "bi-basket2-fill",
        "Pet-friendly (aceita animais de estimação)" => "bi-bookmark-heart-fill",
        "Spa" => "bi-infinity",
        "Salas de reunião/eventos" => "bi-people-fill",
        "Serviço de concierge" => "bi-person-badge-fill",
        "Minibar" => "bi-cup-straw",
        "Televisão a cabo/satélite" => "bi-tv-fill",
        "Área de lazer infantil" => "bi-balloon-fill",
        "Quadra de esportes" => "bi-dash-square-fill",
        "Salão de jogos" => "bi-suit-spade-fill"
      }

      icons[amenity] || "bi-star-fill"  # Fallback para ícone padrão
    end
  end
end
