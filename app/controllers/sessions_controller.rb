class SessionsController < ApplicationController
    def create
        user = User.find_by(username: params[:username])

        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user, except: :password_digest, status: :created
        else
            render json: {errors: ["errors"]}, status: :unauthorized
        end
    end

    def destroy
        if session[:user_id]
            session.delete :user_id
            head :no_content
        else
            render json: {errors: ["Message"]}, status: :unauthorized
        end
    end
end
