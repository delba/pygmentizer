Pygmentizer::Application.routes.draw do
  root 'snippets#index'

  get  '/snippets', to: redirect('/')
  post '/snippets', to: 'snippets#create'

  get '/lexers', to: 'snippets#lexers'

  get '/events', to: 'events#highlight'
end
