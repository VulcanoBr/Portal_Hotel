Rails.application.routes.draw do

  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      passwords: 'users/passwords'

  }

  devise_scope :user do
    get 'admin/login', to: 'users/sessions#new', defaults: { role: 'admin' }
    get 'client/login', to: 'users/sessions#new', defaults: { role: 'client' }
  end

  # Rotas para administradores
  namespace :admin do
    get 'dashboard', to: 'dashboards#index'
    resources :hotels do
      collection do
        get :search
      end
      resources :rooms do
        collection do
          put :update_multiple
          get :room_to_block

          post 'create_block_room', to: 'rooms#create_block_room'
        end
      end
    end
    resources :block_rooms do
      collection do
        get :block_room_list
      end
      member do
        get 'finish'
      end
    end
    resources :room_types
    resources :amenities
    resources :cancellation_reasons
  end

  # Rotas para clientes
  namespace :client do
    resources :reservations, only: [:new, :create] do
      collection do
        get 'search_rooms'
        get 'reservation_histories'
      end
      member do
        get 'reservation_details'
        get 'reservation_cancel'
        patch 'process_cancellation_reservation'
      end
    end

    # Rotas para pagamento, dentro do contexto da reserva
    resources :payments, only: [:new, :create]

    # Rotas para confirmação e conclusão do processo
    resources :confirmations, only: [:new, :create]

    # Outra rota final opcional para mostrar sucesso
    get 'confirmation_success', to: 'confirmations#success', as: 'confirmation_success'
  end

  get 'confirmation_success', to: 'confirmations#success', as: 'confirmation_success'
  # Redireciona após o login com base na função do usuário
  get 'welcome/hotels_list', to: 'welcome#hotels_list', as: 'welcome/hotels_list'
  get 'welcome/hotel_details', to: 'welcome#hotel_details', as: 'welcome/hotel_details'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "welcome#index"
  post 'send_contact', to: 'welcome#send_contact'
end
