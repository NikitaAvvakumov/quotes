class Api::V1::QuotesController < ApplicationController
  respond_to :json

  def preflight
    render :text => '', :content_type => 'text/plain'
  end

  def show
    respond_with Quote.find(params[:id])
  end

  def create
    quote = Quote.new(quote_params)
    if quote.save
      render json: quote, status: 201, location: [:api, quote]
    else
      render json: { errors: quote.errors.full_messages }, status: 422
    end
  end

  private

  def quote_params
    params.require(:quote).permit(:body)
  end
end
