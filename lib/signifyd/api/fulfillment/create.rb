module Signifyd
  module API
    module Fulfillment
      module Create
        module ClassMethods
          def create(order_id, params={}, api_key=nil)
            raise InvalidRequestError.new('You have passed invalid parameters to Fulfillment.create') if params == {}
            Signifyd.request(:post, self.url + '/' + CGI.escape(order_id), params, api_key)
          end
        end

        def self.included(base)
          base.extend(ClassMethods)
        end
      end
    end
  end
end