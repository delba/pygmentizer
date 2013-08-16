class EventsController < ApplicationController
  include ActionController::Live

  def highlight
    response.headers['Content-Type'] = 'text/event-stream'
    $redis.subscribe 'highlight' do |on|
      on.message do |event, data|
        response.stream.write "data: #{data}\n\n"
      end
    end
  rescue IOError
    logger.info "Stream Closed"
  ensure
    response.stream.close
  end
end
