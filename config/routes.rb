Rails.application.routes.draw do
  # get 'batch_rates/index'

  # get 'batch_rates/import'

	root to: 'ltl_rate_lookup#index'
	get 'ltl_discounts' => 'ltl_discount#index', :as => 'ltl_discount'
	get 'batch' => 'batch_rates#index', :as => 'batch'

	resources :batch_rates do
	  collection { post :import }
	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end