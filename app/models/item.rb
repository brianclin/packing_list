# frozen_string_literal: true

class Item < ApplicationRecord
  validates :event_id, presence: false

  def clothing?
    clothing_list = File.readlines('db/data/clothing.txt')
    clothing_list = clothing_list.map(&:strip)
    clothing_list.each do |clothing_item|
      return true if name.downcase.include? clothing_item
    end
    false
  end
end
