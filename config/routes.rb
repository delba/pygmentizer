Pygmentizer::Application.routes.draw do
  root 'snippets#index'

  resources :snippets, only: [:create] do
    get 'lexers', on: :collection
  end

  controller :events do
    get 'highlight'
  end
end
