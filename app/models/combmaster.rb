class Combmaster < ApplicationRecord
  def self.select_tag_name(tag)
    Combmaster.find(tag).tag_name
  end
end
