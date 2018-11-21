require 'pry'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  get '/recipes' do
    @recipe = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    # binding.pry
    @recipe = Recipe.create(params)
    redirect to "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe = get_recipe(params[:id])
    erb :edit
  end

  post '/recipes/:id' do
    @recipe = get_recipe(params[:id])
    @recipe.update(params)
    redirect to "/recipes/#{@recipe.id}"
  end

  patch '/recipes/:id' do
    @recipe = get_recipe(params[:id])
    @recipe.update(params[:recipe])
    redirect to "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id' do
    @recipe = get_recipe(params[:id])
    # binding.pry
    @recipe.destroy
    redirect to '/recipes'
  end

  def get_recipe(id)
    recipe = Recipe.find(id)
  end
end
