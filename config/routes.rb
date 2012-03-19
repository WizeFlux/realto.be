RealtoBe::Application.routes.draw do

    resource :session do
      member {get 'facebook'}
    end

    resources :images, :controller => 'images'

    resource :agency, :controller => 'agency' do
        resource :booklet, :controller =>  'agency_booklet'
        resources :bookings, :controller => 'agency_bookings'
    end

    resources :estates, :controller => 'agency_estates' do
        resources :bookings, :controller => 'estate_bookings'
        resource :pricing, :controller => 'estate_pricing'
        resource :booklet, :controller => 'estate_booklet'
        resource :pricelist, :controller => 'estate_pricelist'
    end

    root :to => 'agency#show'
end
