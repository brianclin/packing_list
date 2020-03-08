class Item < ApplicationRecord
  validates :event_id, presence: false


  def clothing?
    clothing_list = [
        'pants',
        'shorts',
        'swimsuit',
        'sweater',
        'heels',
        'boots',
        'outfit',
        'jeans',
        'gloves',
        'scarf',
        'dress',
        'tank tops',
        'shirts',
        'socks',
        'jacket',
        'hat',
        'sandals',
        'flip flops',
        'shoes'
    ]
    clothing_list.each do |clothing_item|
      if name.downcase.include? clothing_item
        return true
      end
    end
    return false
  end
end

