=begin

    This file is part of the Arachni-RPC Pure project and may be subject to
    redistribution and commercial restrictions. Please see the Arachni-RPC EM
    web site for more information on licensing and terms of use.

=end

require 'openssl'
require 'socket'
require 'yaml'
YAML::ENGINE.yamler = 'syck'

require 'arachni/rpc'
require File.join( File.expand_path( File.dirname( __FILE__ ) ), 'pure', 'connection' )
require File.join( File.expand_path( File.dirname( __FILE__ ) ), 'pure', 'client' )
