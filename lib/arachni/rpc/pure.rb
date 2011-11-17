=begin
                  Arachni-RPC
  Copyright (c) 2011 Tasos "Zapotek" Laskos <tasos.laskos@gmail.com>

  This is free software; you can copy and distribute and modify
  this program under the term of the GPL v2.0 License
  (See LICENSE file for details)

=end

require 'openssl'
require 'socket'

require 'arachni/rpc'
require File.join( File.expand_path( File.dirname( __FILE__ ) ), 'pure', 'connection' )
require File.join( File.expand_path( File.dirname( __FILE__ ) ), 'pure', 'client' )
