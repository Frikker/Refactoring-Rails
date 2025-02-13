module Api
  class ApiController < ApplicationController

    protect_from_forgery with: :null_session

    private

    def render_error(errors)
      render json: errors.messages, status: :unprocessable_entity
    end

    def render_not_found
      render json: { message: "Not Found" }, status: :not_found
    end
  end
end