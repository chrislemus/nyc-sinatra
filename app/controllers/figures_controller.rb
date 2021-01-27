class FiguresController < ApplicationController
  # add controller methods
  get('/figures/new') {
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/new'
  }

  post('/figures') {
    figure = Figure.create(name: params[:figure][:name])

    landmark_ids = params[:figure][:landmark_ids] ? params[:figure][:landmark_ids] : []
    landmark_ids << Landmark.create(name: params[:landmark][:name], figure_id: figure.id) if !params[:landmark][:name].empty?

    landmark_ids.each{ |landmark_id|
      l = Landmark.find(landmark_id)
      l.figure_id = figure.id
      l.save
    }

    new_title_name = params[:title][:name]
    title_ids = new_title_name.empty? ? [] : [Title.create(name: new_title_name).id]
    title_ids << params[:figure][:title_ids]
    title_ids.flatten.each{ |title_id| FigureTitle.create(title_id: title_id, figure_id: figure.id) }
  }
  get('/figures/:id/edit') {
    @figure = Figure.find(params[:id])
    @titles = @figure.titles
    # binding.pry
    erb :'figures/edit'
  }
  patch('/figures/:id') {
    # binding.pry
    figure = Figure.find(params[:id])
    figure.name = params[:figure][:name]
    new_landmark = Landmark.create(name: params[:new_landmark], figure_id: figure.id)
    figure.save
    redirect "/figures/#{figure.id}"
    # @figure = Figure.find(params[:id])
    # erb :'figures/edit'
  }

  get('/figures/:id') {
    @figure = Figure.find(params[:id])
    @landmarks = @figure.landmarks
    erb :'figures/show'
  }

  get('/figures') {
    @figures = Figure.all
    erb :'figures/index'
  }

end
