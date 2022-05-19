# frozen_string_literal: true

require 'spec_helper'

describe Signifyd::Fulfillment do
  let(:hash) { SignifydRequests.valid_fulfillment }
  let(:json) { JSON.dump(hash) }
  let(:fulfillment_id) { (rand * 1000).ceil }
  let(:order_id) { 1 }
  let(:result) { "{\"code\":200}" }

  context '.create' do
    context 'when creating a case with a valid API key' do
      context 'and passing the correct parameters' do
        before {
          Signifyd.api_key = SIGNIFYD_API_KEY

          stub_request(:post, "https://#{Signifyd.api_key}@api.signifyd.com/v2/fullfilments/#{order_id}").
            with(
              :body => json,
              :headers => {
                  'Accept' => '*/*; q=0.5, application/xml',
                  'Accept-Encoding' => 'gzip, deflate',
                  'Content-Length' => json.size,
                  'Content-Type' => 'application/json',
                  'User-Agent' => 'Signifyd Ruby v2'
                }
            ).to_return(
              :status => 200,
              :body => result,
              :headers => {}
            )
        }

        after {
          Signifyd.api_key = nil
        }

        subject {
          Signifyd::Fulfillment.create(order_id, hash)
        }

        it { should be_true }
        it { should_not be_nil }
        it { expect(subject[:code]).to eq(200) }
        it { expect(subject[:body][:code]).to eq(JSON.parse(result)[:code]) }
      end

      context 'and passing incorrect or nil parameters' do
        before {
          Signifyd.api_key = SIGNIFYD_API_KEY
        }

        after {
          Signifyd.api_key = nil
        }

        it { lambda { Signifyd::Fulfillment.create() }.should raise_error }
      end
    end

    context 'when creating a case with an invalid API key' do
      it { lambda { Signifyd::Case.create(hash) }.should raise_error }
    end
  end
end
