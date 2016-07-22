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
    @link = []
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @link[0]
  end

  def last
    @link[-1]
  end

  def empty?
    @link.empty?
  end

  def get(key)
    @link.each do |el|
      return el.val if el.key == key
    end
    nil
  end

  def include?(key)
    !get(key).nil?
  end

  def insert(key, val)
    new_link = Link.new(key, val)
    if empty?
      @link << new_link
    elsif !include?(key)
      last.next = new_link
      new_link.prev = last
      @link << new_link
    else
      link.each do |el|
        el.val = val if el.key == key
      end
    end

  end

  def remove(key)
    previous_link = nil
    next_link = nil
    @link.each_with_index do |el, id|
      if el.key == key
        previous_link = @link[id-1]
        next_link = @link[id + 1]
        @link.delete(el)
      end
    end
    next_link.prev = previous_link
    previous_link.next = next_link

  end

  def each(&blk)
    @link.each{|el| blk.call(el)}
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
