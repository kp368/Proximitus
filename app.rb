require 'rubygems'
require 'sinatra'
require 'hominid' # MailChimp
require 'pony'

configure do

  # MailChimp configuration: ADD YOUR OWN ACCOUNT INFO HERE!
  set :mailchimp_api_key, ENV['MAILCHIMP_API_KEY']
  set :mailchimp_list_name, ENV['MAILCHIMP_LIST_NAME']

end

raise Exception.new("Please specify MAILCHIMP_API_KEY in your environment") if settings.mailchimp_api_key.nil?
raise Exception.new("Please specify MAILCHIMP_LIST_NAME in your environment") if settings.mailchimp_list_name.nil?

get '/' do
  erb :index
end

post '/signup' do
  fname, lname = params[:name].split(' ', 2)
  email = params[:email]
  shopper = params[:shopper].nil? ? "no" : "yes"
  owner = params[:owner].nil? ? "no" : "yes"
  
  merge_vars = {"FNAME"=>fname, "LNAME"=>lname, "SHOPPER"=>shopper, "OWNER"=>owner}
  
  halt 500 if email.nil? || email.strip.empty?

  mailchimp = Hominid::API.new(settings.mailchimp_api_key)
  list_id = mailchimp.find_list_id_by_name(settings.mailchimp_list_name)
  raise "Unable to retrieve list id from MailChimp API." unless list_id

  # http://apidocs.mailchimp.com/api/rtfm/listsubscribe.func.php
  # double_optin, update_existing, replace_interests, send_welcome are all true by default (change as desired)
  mailchimp.list_subscribe(list_id, email, merge_vars, 'html', true, true, true, true)
  
  "Success."
end

post '/contact' do
  Pony.mail :to => "sam@proximitus.co",
            :from => params[:email],
            :subject => "Proximitus: message from #{params[:name]}!",
            :body => params[:message]
end

# URL for Mill Road Mag
get '/millroad' do
  redirect '/'
end