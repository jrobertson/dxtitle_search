#!/usr/bin/env ruby

# file: dxtitle_search.rb

require 'dynarex'


class DxTitleSearch

  def initialize(obj=nil, sources: obj, debug: false)

    @debug = debug

    s = if sources then
    
      dx = Dynarex.new(sources)
      dx.all.map {|x| read x.uri }.join
    
    elsif obj then
      
      # is it a Dynarex file location?
      if obj.lines.length < 2 then

        read obj

      else
        
        obj
        
      end
    end
  
    @h = h = s.lines.inject({}) do |r,x|
      key, value = x.split(/\s+(?=[^\s]+$)/,2)
      r.merge(key.rstrip => value)
    end

    @a = h.keys

  end

  def search(keywords)
    
    phrases = @a.grep /#{keywords}/i

    # find out the keywords count for each entry found
    a0 = keywords.split.flat_map do |x| 
      next if @a.length < 2
      @a.grep /#{x}/i 
    end
    
    a = a0.uniq.map do |entry|
      [entry, entry.scan(/#{keywords.split.join('|')}/).uniq.count]
    end

    # sort by keywords found per entry and then date
    #a2 = (phrases + a).uniq.sort do |x, x2|
    a2 = a.sort do |x, x2| 
      -([x.last, x.first[/^\d+/], ] <=> [x2.last, x2.first[/^\d+/]])
    end

    # format each result as a Hash object
    a3 = (phrases + a2).map do |x|

      if x.length > 1 then
        line, _ = x
      else
        line = x
      end
      
      puts 'line: ' + line.inspect if @debug
     
      rawtime, title = line.split(/ +/,2)
      puts 'title: ' + title.inspect if @debug

      {title: title, url: @h[line], date: Time.at(rawtime.to_i)}

    end

    puts 'a3: ' + a3.inspect if @debug

    return a3

  end
  
  def tag_search(keywords)
    a = @a.flat_map {|x| x.split(/#/,2).last.split(/\s*#/)}
    a.grep(/^#{keywords}/i).map(&:downcase).uniq
  end
  
  private
  
  def read(source)

    dx = Dynarex.new(source)

    dx.all.map do |x|
      "%d %s %s" % [Time.parse(x.created).to_i, x.title, x.url]
    end.join("\n")
    
  end

end
