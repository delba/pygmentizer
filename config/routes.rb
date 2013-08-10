Pygmentizer::Application.routes.draw do
  root 'snippets#index'

  get  '/snippets', to: redirect('/')
  post '/snippets', to: 'snippets#create'
end
