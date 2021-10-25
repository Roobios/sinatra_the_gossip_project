require 'bundler'
Bundler.require

require 'gossip'

class ApplicationController < Sinatra::Base
    
    get '/' do
        erb:index, locals: {gossips: Gossip.all}
    end
    
    get '/gossips/new/' do
		erb:new_gossips
	end

    post '/gossips/new/' do
        Gossip.new(params["gossip_content"], params["gossip_author"]).save
        redirect '/'
    end

    get '/gossips/:id/' do
        id = params['id'].to_i
        erb:show, locals:{gossip: Gossip.find(id), id: id, comments: Gossip.all_comments}
    end

    post '/gossips/:id/' do
        id = params['id'].to_i
        Gossip.save_comment(params["gossip_comment"], id)
        redirect '/'
    end


end
