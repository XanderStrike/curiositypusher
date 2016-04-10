require 'sinatra'
require 'pusher'
require 'slack-notifier'

slack_client = Slack::Notifier.new ENV['SLACK_INCOMING_URL']
pusher_client = Pusher::Client.new(
  app_id: '196507',
  key: '18d0e1f96d237f08631c',
  secret: ENV['PUSHER_SECRET'],
  encrypted: true
)

get '/' do
  send_file 'views/index.html'
end

get '/post' do
  pusher_client.trigger(
    'curiosity',
    'new_message',
    message: params[:message])
  slack_client.ping params[:message]
end
