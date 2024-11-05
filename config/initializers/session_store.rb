Rails.application.config.session_store :cookie_store, key: '_portal_hotel_session', secure: Rails.env.production?, httponly: true
