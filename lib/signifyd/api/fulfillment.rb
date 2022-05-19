# frozen_string_literal: true

module Signifyd
  module API
    module Fulfillment
      module ClassMethods
        def create(order_id, params={}, api_key=nil)
          raise InvalidRequestError.new('You have passed invalid parameters to Case.create') if params == {}
          Signifyd.request(:post, "#{self.url}/#{order_id}", params, api_key)
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
