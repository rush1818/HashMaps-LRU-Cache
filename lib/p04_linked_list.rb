require 'byebug'
class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable
  attr_accessor :link

  def initialize
    @link_start = Link.new(nil, nil)
    @link_end = Link.new(nil, nil)
    @link_start.next = @link_end
    @link_end.prev = @link_start
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @link_start.next
  end

  def last
    @link_end.prev
  end

  def empty?
    @link_start.next == @link_end
  end

  def get(key)
    # byebug
    each do |link|
      return link.val if link.key == key
    end
    nil
  end

  def include?(key)
    !get(key).nil?
  end

  def insert(key, val)
    new_link = Link.new(key, val)
    if empty?
      @link_start.next = new_link
      @link_end.prev = new_link
      new_link.next = @link_end
      new_link.prev = @link_start
    elsif !include?(key)
      last.next = new_link
      new_link.prev = last
      new_link.next = @link_end
      @link_end.prev = new_link
    else
      self.each do |link|
        link.val = val if link.key == key
      end
    end
    new_link
  end

  def remove(key)
    current_link = nil
    self.each do |link|
      current_link = link if link.key == key
    end
    return "" if current_link.nil?
    current_link.prev.next = current_link.next
    current_link.next.prev = current_link.prev
    current_link.prev = nil
    current_link.next = nil
  end

  def each(&blk)
    # debugger
    start = @link_start
    while start.next != @link_end
      blk.call(start.next)
      start = start.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
