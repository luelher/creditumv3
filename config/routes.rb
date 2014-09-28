Creditumv3::Application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'admin'
  devise_for :users, 
                :controllers => {
                  :sessions => "sessions"
                }

  get 'dashboard' => 'dashboard#index'
  get 'principal' => 'portal#index'
  get 'acerca' => 'portal#acerca'
  get 'contacto' => 'portal#contacto'
  get 'en_construccion' => 'construccion#index'

  get 'informacion_crediticia' => 'informacion_crediticia#index'
  post 'informacion_crediticia' => 'informacion_crediticia#search'

  get 'asistencia_telefonica' => 'asistencia_telefonica#index'
  post 'search_users' => 'asistencia_telefonica#search_users'
  post 'asistencia_telefonica' => 'asistencia_telefonica#search'

  get 'importar_registros' => 'importar_registros#index'
  post 'importar_registros' => 'importar_registros#import'
  post 'search_personas' => 'importar_registros#search_personas'
  post 'search_facturas' => 'importar_registros#search_facturas'

  get 'importar_archivos' => 'importar_archivos#index'
  post 'importar_archivos' => 'importar_archivos#import'

  get 'estado_cuenta' => 'estado_cuenta#index'

  get 'detalle_facturacion/:id' => 'detalle_facturacion#show', as: 'detalle_facturacion_show'
  get 'detalle_facturacion' => 'detalle_facturacion#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'portal#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
