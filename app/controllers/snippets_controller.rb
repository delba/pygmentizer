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

  def lexers
    extname = File.extname(params[:filename])
    lexer   = Pygments::Lexer.find_by_extname(extname)

    if lexer
      render json: { language: lexer.name }
    else
      head :no_content
    end
  end

private

  def snippet_params
    params.require(:snippet).permit(:filename, :language, :content)
  end
end
