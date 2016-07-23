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
    eject! if count > @max
    return value
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    link.prev.next = link.next
    link.next.prev = link.prev
    link.prev = @store.last
    link.next = @store.last.next
    @store.last.next = link

  end

  def eject!
    oldest_link = @store.first
    oldest_link.prev.next = oldest_link.next
    oldest_link.next.prev = oldest_link.prev
    @map.delete(oldest_link.key)
  end
end
