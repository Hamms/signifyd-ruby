module Signifyd
  module API
    module Transaction
      module Create
        module ClassMethods
          def create(params={}, api_key=nil)
            raise InvalidRequestError.new('You have passed invalid parameters to Transaction.create') if params == {}
            Signifyd.request(:post, self.url, params, api_key)
          end
        end

        def self.included(base)
          base.extend(ClassMethods)
        end
      end
    end
  end
end