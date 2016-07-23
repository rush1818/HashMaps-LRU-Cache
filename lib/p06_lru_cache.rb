require 'byebug'
  require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    # byebug
    if @map.include?(key)
      link = @map.get(key)
      update_link!(link)
      return @store.get(key)
    elsif count >= @max
      eject!
      calc!(key)
    else
      calc!(key)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    value = @prc.call(key)
    @map.set(key, @store.insert(key,value))
    return value
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    @store.remove(link.key)
    @store.insert(link.key, link.val)

  end

  def eject!
    oldest_link = @store.first
    oldest_link_key = oldest_link.key

    @map.delete(oldest_link)
    @store.remove(oldest_link_key)
  end
end
