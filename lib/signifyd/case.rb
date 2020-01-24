module Signifyd
  class Case < Resource
    include Signifyd::API::Case::Create
    include Signifyd::API::Case::List
    include Signifyd::API::Case::Update
  end
end