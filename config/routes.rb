Ssnotas::Application.routes.draw do

  resources :notas_attachment

  resources :estados_nota do
    get 'delete', on: :member
  end
  resources :nota_persona, only: :create
  resources :nota_persona do
     get 'delete', on: :collection
  end

  resources :home, only: :index
  root 'home#index'


  devise_for :users, path: "sessions", path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock' }
  #devise_for :users
  resources :users
  resources :users do
    member do
      get 'editpwd'
      post 'updatepwd'
    end
  end
  get "notas_recibidas/search"
  get "notas_recibidas"  => "notas_recibidas#index"
  get "notas_recibidas/:id" => "notas_recibidas#show" , as: "nota_recibida"
  #manejo de versiones
  post "versions/:id/revert" => "versions#revert", :as => "revert_version"


  resources :notas_temporales do
    get 'search', on: :collection
    get 'cupon', on: :member
    get 'barcode', on: :member

  end

  resources :notas_temporales

  resources :entidades do
    get 'change_es_facultad', on: :member
    get 'delete', on: :member
    get 'change_es_actual', on: :member
    get 'find_remitentes', on: :collection
    get 'find_destinatarios', on: :collection
    get 'get_actual_cargo_dependencia', on: :collection
    get 'search', on: :collection
  end
  resources :entidades

  resources :cargos do
    get 'search', on: :collection
    get 'delete', on: :member
  end

  resources :personas do
    get 'search', on: :collection
    get 'delete', on: :member
  end


  #resources :roles


  #resources :profile  do
  #  collection do
  #    get 'edit'
  #    post 'update'
  #    get 'password'
  #    post 'update_password'
  #  end
  #end

####USER OLD
  get "profile" => "profile#edit"
  post "profile/update" => "profile#update"
  get "profile/password" => "profile#password"
  post "profile/update_password" => "profile#update_password"



####USER OLD  get "log_in" => "sessions#new", :as => "log_in"
####USER OLD  get "log_out" => "sessions#logout", :as => "log_out"
####USER OLD  get "sign_up" => "users#new", :as => "sign_up"


####USER OLD  resources :users do
####USER OLD    member do
####USER OLD      get 'editpwd'
####USER OLD      post 'updatepwd'
####USER OLD    end
####USER OLD  end




  resources :organismos do
    get 'search', on: :collection
    get 'delete', on: :member
  end

  resources :notas do
    get 'search', on: :collection
    get 'search_pendientes', on: :collection
    get :new_dependencia,   :on => :collection
    post :create_dependencia,   :on => :collection
    get :new_remitente,   :on => :collection
    post :create_remitente,   :on => :collection
    get 'pendientes', on: :collection
    get 'edit_pendiente', on: :member
    post 'process_pendiente', on: :collection
    get 'barcode', on: :member
    post 'asociar', on: :collection
    get 'find_by', on: :collection
    get 'shortcut', on: :member
    get 'shortcut_pendiente', on: :member
    get 'att', on: :member    

  end





  resources :notas

  resources :destinatarios

  resources :autoridades

  resources :tipos_notas do
    get 'search', on: :collection
    get 'delete', on: :member
  end
  resources :remitentes do
    get :getByDependencia,   :on => :collection
  end

  resources :remitentes


  resources :dependencias do
    get 'search', on: :collection
    get 'delete', on: :member
  end

####USER OLD  root :to => "sessions#new"


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
  get "datatable_i18n" => "datatable"
end
