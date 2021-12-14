module Types
  class Status < Types::BaseEnum
    value :future
    value :current
    value :completed
  end
end
