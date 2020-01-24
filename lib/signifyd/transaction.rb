module Signifyd
  class Transaction < Resource
    include Signifyd::API::Transaction::Create
  end
end