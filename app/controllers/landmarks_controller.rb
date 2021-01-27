class LandmarksController < ApplicationController
  # add controller methods
  get('/landmarks/new') {
    erb :'landmarks/new'
  }

  post('/landmarks') {
    Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
    redirect '/landmarks'
  }

  get('/landmarks') {
    @landmarks = Landmark.all
    erb :'landmarks/index'
  }
  patch('/landmarks') {
    landmark = Landmark.find(params[:landmark][:id])
    landmark.name = params[:landmark][:name]
    landmark.year_completed = params[:landmark][:year_completed]
    landmark.save
    redirect "/landmarks/#{landmark.id}"
  }

  get('/landmarks/:id/edit') {
    @landmark = Landmark.find(params[:id])
    erb :'landmarks/edit'
  }

  get('/landmarks/:id') {
    @landmark = Landmark.find(params[:id])
    erb :'landmarks/show'
  }
end
