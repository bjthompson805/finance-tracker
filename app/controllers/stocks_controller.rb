class StocksController < ApplicationController

  def search
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      if @stock
        respond_to do |format|
          format.js { render partial: 'users/result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Please enter a valid symbol to search"
          format.js { render partial: 'users/result' }
        end
      end    
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a symbol to search"
        format.js { render partial: 'users/result' }
      end
    end
  end

  def refresh
    current_user.stocks.each do |stock|
      new_stock = Stock.new_lookup(stock.ticker)
      stock.last_price = new_stock.last_price
      stock.save
    end
    redirect_to my_portfolio_path
  end
end