module Api
  class ApiController < ApplicationController

    private

    def render_error(errors)
      render json: errors.messages, status: :unprocessable_entity
    end

    def render_not_found
      render json: { message: "Not Found" }, status: :not_found
    end
  end
end