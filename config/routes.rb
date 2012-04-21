RealtoBe::Application.routes.draw do

    resource :session do
      member {get 'facebook'}
    end

    resources :images, :controller => 'images'

    resource :agency, :controller => 'agencies' do
        resources :bookings, :controller => 'agency_bookings'
        resources :booklets, :controller =>  'agency_booklets'
        resource :map, :controller => 'agency_map'
    end

    resources :estates, :controller => 'agency_estates' do
        resources :bookings, :controller => 'estate_bookings'
        resources :booklets, :controller => 'estate_booklets'
        resource :pricing, :controller => 'estate_pricing'
        resource :pricelist, :controller => 'estate_pricelist'
        resource :map, :controller => 'estate_map'
    end

    root :to => 'agencies#show'
end
