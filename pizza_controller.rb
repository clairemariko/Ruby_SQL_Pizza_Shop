require( 'sinatra' )
require( 'sinatra/contrib/all' ) if development?
require( 'pry-byebug' )
require( './models/pizza' )
require_relative('./models/pizza')

get '/pizza' do
  @pizzas = Pizza.all()
  erb ( :index )
end

get '/pizza/new' do 
  erb( :new )
end

#SHOW
get '/pizza/:id' do
  @pizza = Pizza.find(params[:id])
  erb(:show)
end

#EDIT
get '/pizza/:id/edit' do
  @pizza = Pizza.find(params[:id])
erb(:edit)
end

#update
post '/pizza/:id' do
 @pizza = Pizza.update(params)
 redirect to("/pizza/#{params[:id]}")
end

#CREATE
post '/pizza' do 
  @pizza = Pizza.new( params )
  @pizza.save
  erb( :create )
end

#DESTROY
post '/pizza/:id/delete' do
  Pizza.destroy( params[:id])
  redirect to('/pizza')
end





