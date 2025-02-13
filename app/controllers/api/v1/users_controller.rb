
module Api
  module V1
    class UsersController < ApiController
      def show
        render json: User.find(params[:id])
      end

      def create
        @user = Users::Create.run(params)
        if @user.valid?
          render json: { user: @user }, status: :created
        else
          render_error(@user.errors)
        end
      end
    end

  end
end
