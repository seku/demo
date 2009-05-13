ActionController::Routing::Routes.draw do |map|
  map.resources :posts, :has_one => :image
	map.resources :photo
	map.resources :image
  map.resource :account, :controller => "users"
  map.resources :users, :has_one => :photo
	map.resource :user_session
	map.root :controller => "posts", :action => "index"
	map.resources :currencies, :collection => { :destroy_all => :delete }
	map.resources :sparklines
	map.resources :emails
end
