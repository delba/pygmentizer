class EventsController < ApplicationController
  include ActionController::Live

  def highlight
    response.headers['Content-Type'] = 'text/event-stream'
    $redis.subscribe 'highlight' do |on|
      on.message do |channel, msg|
        response.stream.write "data: #{msg}\n\n"
      end
    end
  rescue IOError
    logger.info "Stream Closed"
  ensure
    response.stream.close
  end

  def change
    response.headers['Content-Type'] = 'text/event-stream'
    $redis.psubscribe 'change:*' do |on|
      on.message do |pattern, channel, msg|
        response.stream.write "event: #{pattern}\n"
        response.stream.write "data: #{msg}\n\n"
      end
    end
  rescue IOError
    logger.info "Stream Closed"
  ensure
    response.stream.close
  end
end
