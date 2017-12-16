class PeopleChannel < ApplicationCable::Channel
  def subscribed
    stream_from "people:connection"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def drop
    PeopleChannel.broadcast_to('connection', '')
  end
end
