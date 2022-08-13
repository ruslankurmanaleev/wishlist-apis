class BaseSerializer
  include JSONAPI::Serializer

  attribute :created_at do |wishlist|
    format_date_time(wishlist.created_at)
  end

  attribute :updated_at do |wishlist|
    format_date_time(wishlist.updated_at)
  end

  def self.format_date_time(datetime)
    datetime.strftime("%d.%m.%Y %H:%M")
  end
end
