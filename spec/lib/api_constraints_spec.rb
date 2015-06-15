require 'rails_helper'

RSpec.describe APIConstraints do
  let(:api_constraints_v1) { APIConstraints.new(version: 1) }
  let(:api_constraints_v2) { APIConstraints.new(version: 2, default: true) }

  describe 'matches?' do
    it 'returns true when the version matches the Accept header' do
      request = double(host: 'api.quotes.dev',
                       headers: { "Accept" => "application/api.quotes.v1" } )
      expect(api_constraints_v1.matches?(request)).to eq true
    end

    it 'returns false when the version does not match the Accept header' do
      request = double(host: 'api.quotes.dev',
                       headers: { "Accept" => "application/api.quotes.v2" } )
      expect(api_constraints_v1.matches?(request)).to eq false
    end

    it 'returns true when no version is specified (sets default)' do
      request = double(host: 'api.quotes.dev')
      expect(api_constraints_v2.matches?(request)).to eq true
    end
  end
end
