class RecipesController < ApplicationController
    def index
        if session[:user_id]
            recipes = Recipe.all
            render json: recipes, include: [:title, :instructions, :minutes_to_complete], include: :user, status: :created
        else
            render json: {errors: ["errors"]}, status: :unauthorized
        end
    end

    def create
        if session[:user_id]
            recipe = Recipe.create(user_id: session[:user_id], title: params[:title], instructions: params[:instructions], minutes_to_complete: params[:minutes_to_complete])
            if recipe.valid?
                render json: recipe, includes: [:title, :instructions, :minutes_to_complete], include: :user, status: :created
            else
                render json: {errors: ["errors"]}, status: :unprocessable_entity
            end
        else
            render json: {errors: ["errors"]}, status: :unauthorized
        end
    end
end
