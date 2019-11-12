#!/usr/bin/env ruby

# file: dxtitle_search.rb

require 'indexer101'


class DxTitleSearch

  def initialize(obj=nil, sources: nil, debug: false)

    @debug = debug
    @indexer = Indexer101.new debug: debug

    s = if sources then
    
      dx = Dynarex.new(sources)      
      @indexer.scan_dxindex dx.all.map(&:uri), level: 1
    
    elsif obj and obj.lines.length < 2 

      @indexer.scan_dxindex  obj, level: 1
        
    end
  
    @indexer.build

  end

  def search(keywords)    

    a2 = @indexer.search keywords.split(/[\s:"!\?\(\)£]+(?=[\w#_'-]+)/)
    # format each result as a Hash object
    a3 = a2.map do |date, title, url|

      {title: title, url: url, date: date}

    end

    puts 'a3: ' + a3.inspect if @debug
    
    def a3.to_dx()
      Dynarex.new('results/result(title, url, date)').import(self)
    end

    return a3

  end
  
  def tag_search(keywords)    
    r = @indexer.lookup *keywords.split(/[\W]+(?=[\w]+)/).map {|x| "#" + x}
    r.map {|x| x.to_s[1..-1]}
  end  

end
