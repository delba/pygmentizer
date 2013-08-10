class SnippetsController < ApplicationController
  def index
    @snippet  = Snippet.new
    @snippets = Snippet.all
  end

  def create
    @snippet = Snippet.new(snippet_params)

    if @snippet.save
      redirect_to root_url
    else
      @snippets = Snippet.all
      render :index
    end
  end

private

  def snippet_params
    params.require(:snippet).permit(:filename, :language, :content)
  end
end
