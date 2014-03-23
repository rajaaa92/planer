#https://github.com/mongoid/mongoid/pull/2947
class Moped::BSON::ObjectId
  def to_json(*args)
    "\"#{to_s}\""
  end
end
