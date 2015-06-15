require 'rails_helper'

RSpec.describe Api::V1::QuotesController, type: :controller do
  before(:each) { request.headers['Accept'] = 'application/api.quotes.v1' }

  describe 'GET #show' do
    let(:quote) { FactoryGirl.create :quote }

    before(:each) do
      get :show, id: quote.id, format: :json
    end

    it 'returns the quote' do
      get_response = JSON.parse(response.body, symbolize_names: true)
      expect(get_response[:body]).to eq quote.body
    end

    it { is_expected.to respond_with 200 }
  end

  describe 'POST #create' do
    let(:quote_attrs) { FactoryGirl.attributes_for :quote }

    context 'when valid data submitted' do
      before(:each) do
        post :create, { quote: quote_attrs }, format: :json
      end

      it 'renders JSON representation of the created quote record' do
        quote_response = JSON.parse(response.body, symbolize_names: true)
        expect(quote_response[:body]).to eq quote_attrs[:body]
      end

      it { is_expected.to respond_with 201 }
    end

    context 'when invalid data submitted' do
      before(:each) do
        post :create, { quote: { body: '' } }, format: :json
      end

      it 'returns errors' do
        quote_response = JSON.parse(response.body, symbolize_names: true)
        expect(quote_response).to have_key(:errors)
      end

      it 'returns specific errors' do
        quote_response = JSON.parse(response.body, symbolize_names: true)
        expect(quote_response[:errors]).to include "Body can't be blank"
      end

      it { is_expected.to respond_with 422 }
    end
  end
end
