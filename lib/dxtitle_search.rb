#!/usr/bin/env ruby

# file: dxtitle_search.rb

require 'dynarex'


class DxTitleSearch

  def initialize(obj, debug: false)

    @debug = debug

    # is it a Dynarex file location?
    s = if obj.lines.length < 2 then

      xml = RXFHelper.read(obj).first

      dx = Dynarex.new(xml)

      dx.all.map do |x|
       "%d %s %s" % [Time.parse(x.created).to_i, x.title, x.url]
      end.join("\n")

    else
      obj
    end

    @h = h = s.lines.inject({}) do |r,x|
      key, value = x.split(/\s+(?=[^\s]+$)/,2)
      r.merge(key.rstrip => value)
    end

    @a = h.keys

  end

  def search(keywords)

    # find out the keywords count for each entry found
    a = keywords.split.flat_map {|x| @a.grep /#{x}/i }.uniq.map do |entry|
      [entry, entry.scan(/#{keywords.split.join('|')}/).uniq.count]
    end

    # sort by keywords found per entry and then date
    a2 = a.sort do |x, x2| 
      -([x.last, x.first[/^\d+/], ] <=> [x2.last, x2.first[/^\d+/]])
    end

    # format each result as a Hash object
    a3 = a2.map do |x|

      line, _ = x
      puts 'line: ' + line.inspect if @debug
     
      rawtime, title = line.split(/ +/,2)
      puts 'title: ' + title.inspect if @debug

      {title: title, url: @h[line], date: Time.at(rawtime.to_i)}

    end

    puts 'a3: ' + a3.inspect if @debug

    return a3

  end

end

