#!/usr/bin/env ruby

# file: dxtitle_search.rb

require 'indexer101'


class DxTitleSearch

  def initialize(obj=nil, sources: nil, level: 1, debug: false)

    @debug = debug
    @indexer = Indexer101.new debug: debug
    @level = level

    s = if sources then
    
      dx = Dynarex.new(sources)      
      puts 'before scan_dxindex' if @debug
      a = dx.all.map(&:uri)
      puts 'a: ' + a.inspect if @debug
      @indexer.scan_dxindex a, level: level
    
    elsif obj and (obj.is_a?(DxLite) or obj.is_a?(Dynarex)) or obj.lines.length < 2 

      @indexer.scan_dxindex  obj, level: level
        
    end
  
    #jr230620 @indexer.build

  end

  def search(keywords, minchars: 3)    

    a2 = @indexer.search keywords.split(/[\s:"!\?\(\)£]+(?=[\w#_'-]+)/), \
        minchars: minchars
    # format each result as a Hash object
    a3 = a2.map do |date, title, url|

      {title: title, url: url, date: date}

    end

    puts 'a3: ' + a3.inspect if @debug
    
    @dx = Dynarex.new('results/result(title, url, date)').import(a3)
    
    def a3.to_dx()
      Dynarex.new('results/result(title, url, date)').import(self)
    end
    
    def a3.to_tags()
      a = self.map {|x| x[:title].scan(/(?<=#)(\w+)/)}.flatten
      a.uniq.sort.map {|x| [x, a.count(x)]}
    end    
    
    def a3.search(keywords)
      
      dx = Dynarex.new('results/result(title, url, date)').import(self)

      level = keywords[0] == '#' ? 0 : 1
      dts = DxTitleSearch.new dx, level: level
      dts.search keywords
      
    end
    
    def a3.tag_search(keywords)
      
      dx = Dynarex.new('results/result(title, url, date)').import(self)

      level = keywords[0] == '#' ? 0 : 1
      dts = DxTitleSearch.new dx, level: level
      dts.tag_search keywords
      
    end    

    return a3

  end
  
  def tag_search(keywords)    
    r = @indexer.lookup *keywords.split(/[\W]+(?=[\w]+)/).map {|x| "#" + x}
    r.map {|x| x.to_s[1..-1]}
  end

  def to_tags()
    
    a = @indexer.index.map do |key, value|
      [key.to_s[1..-1], value.length]
    end
    
    a.sort_by(&:first)
    
  end

end
