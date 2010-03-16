
class Video < Ohm::Model
  attribute :url
  counter   :viewed
  set       :tags
end
