class UsersController < ApplicationController

    get '/signup' do
        erb :'/users/new'
    end

    post '/signup' do
        user = User.create(email: params["email"], password: params["password"])
            if user.email.blank? || user.password.blank? || User.find_by_email(params["email"])
            redirect '/signup'
            else
            user.save
            session[:user_id] = user.user_id
            redirect '/tweets'
        end
    end

    get '/login' do
        erb :'/login'
    end

    post 'login' do
        user = User.find_by_email(params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.user_id
            redirect '/tweets'
        else 
            redirect '/signup'
        end 
    end

    get '/logout' do
        if logged_in?
            session.destory
            redirect '/login'
        else
            redirect to '/'
        end
    end

 end
