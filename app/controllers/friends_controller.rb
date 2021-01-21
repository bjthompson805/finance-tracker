class FriendsController < ApplicationController
  def search
    if params[:friend].present?
      @friend = Friendship.new_lookup(params[:friend])
      if @friend
        respond_to do |format|
          format.js { render partial: 'users/result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Please enter a valid email to search"
          format.js { render partial: 'users/result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter an email to search"
        format.js { render partial: 'users/result' }
      end
    end
  end
end