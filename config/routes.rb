Rails.application.routes.draw do
	root to: 'ltl_rate_lookup#index'
	get 'ltl_discounts' => 'ltl_discount#index', :as => 'ltl_discount'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
