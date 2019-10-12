class Combmaster < ApplicationRecord
  def self.select_tag_name(tag)
    Combmaster.find_by(id: tag)&.tag_name
  end
end
