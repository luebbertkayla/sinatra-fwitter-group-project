class UsersController < ApplicationController
    
    get "/signup" do
        if logged_in?
            redirect "/tweets"
        else 
            erb :signup
        end 
    end
    
      post "/signup" do
        if params[:username].empty?
          redirect to '/signup'
        end
    
        if params[:email].empty?
          redirect to '/signup'
        end
    
        if params[:password].empty?
          redirect to '/signup'
        end 
    
        @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
        if @user.save
          redirect '/tweets'
        else
          redirect '/signup'
        end
      end
    
      get "/login" do
        if logged_in?
            redirect to "/tweets"
        else 
            erb :"users/login"
        end 
    end
    
        post "/login" do
            @user = User.find_by(:username => params[:username])
    
            if @user && @user.authenticate(params[:password])
                session[:user_id] = @user.id
                redirect to "/tweets"
            else 
                redirect to "users/login"
            end 
        end
    
      get "/logout" do
            session.clear
            redirect to "users/login"
        end
    
    get "/users/:slug" do 
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
    end 


end
