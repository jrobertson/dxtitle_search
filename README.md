# Introducing the DxTitle_search gem

## Usage
    
    require 'dxtitle_search'

    s = 'http://a0.jamesrobertson.me.uk/snippets/dynarex.xml'

    dts = DxTitleSearch.new(s)
    result = dts.search('ssh mount')
    result.each do |rx|
      puts rx[:title]
      puts rx[:url]
      puts rx[:date].to_s
      puts '----------------------------------'
    end


## Output

<pre>
Automatically mounting multiple dir ... #sshfs #mount #unmount #ssh #directories
http://www.jamesrobertson.eu/snippets/2011/08/25/1947hrs.html
2011-08-25 19:47:43 +0100
----------------------------------
Finding the IP address of your Raspberry Pi 3 on the LAN #rpi #raspberrypi #system #ssh #query #model #proc #cpuinfo
http://www.jamesrobertson.eu/snippets/2017/oct/29/finding-the-ip-address-of-your-raspberry-pi-3-on-the-lan.html
2017-10-29 19:22:13 +0000
----------------------------------
Finding the IPv6 addresses for devices on my LAN #ipscanner #ipv6 #lan #aliases #ssh
http://www.jamesrobertson.eu/snippets/2015/oct/18/finding-the-ipv6-addresses-for-devices-on-my-lan.html
2015-10-18 13:51:01 +0100
----------------------------------
Identifying which of my SSH hosts are online #ssh #hosts #ipscanner
http://www.jamesrobertson.eu/snippets/2015/may/20/identifying-which-of-my-ssh-hosts-are-online.html
2015-05-20 18:05:24 +0100
----------------------------------
Installing a gem to several machines at ... #ssh #remote #execution #many #hosts
http://www.jamesrobertson.eu/snippets/2012/jul/22/installing-a-gem-to-several-machines-at.html
2012-07-22 21:34:45 +0100
----------------------------------
Remotely running a command in the rcscrip ... #ssh #remote #netssh #gg #rcscript
http://www.jamesrobertson.eu/snippets/2012/may/12/remotely-running-a-command-in-the-rcscrip.html
2012-05-12 23:23:59 +0100
----------------------------------
Automating the generation o ... #ssh #keys #publickeys #generate #authorizedkeys
http://www.jamesrobertson.eu/snippets/2011/08/23/1725hrs.html
2011-08-23 17:25:03 +0100
----------------------------------
Executing an SSH command remotely  #ssh #netssh #remote #command #execution
http://www.jamesrobertson.eu/snippets/2011/08/23/1251hrs.html
2011-08-23 12:51:04 +0100
----------------------------------
</pre>

## Resources

* dxtitle_search https://rubygems.org/gems/dxtitle_search

dxtitle_search search keywords dynarex title query
