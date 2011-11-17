require File.join( File.expand_path( File.dirname( __FILE__ ) ), '../lib/arachni/rpc/', 'pure' )

# require 'arachni/rpc/pure'
require 'pp'

client = Arachni::RPC::Pure::Client.new(
    :host  => 'localhost',
    :port  => 7331,
    :token => 'superdupersecret',
    :serializer => Marshal
)

begin
    # 'bench2' doesn't exist...
    client.call( 'bench2.foo', 1 )
rescue Arachni::RPC::Exceptions::InvalidObject => e
    pp e
    #   => #<Arachni::RPC::Exceptions::InvalidObject: Trying to access non-existent object 'bench2'.>
end

# This is just an echo method so it will return: 1
pp client.call( 'bench.foo', 1 )
#   => 1

# make access more natural, map (proxy actually) the remote object to a local one
bench = Arachni::RPC::RemoteObjectMapper.new( client, 'bench' )

pp bench.foo( 2 )
#   => 2

begin
    # doesn't exist so we'll get an exception,
    # won't reach the remote object
    #
    bench.does_not_exist
rescue Arachni::RPC::Exceptions::InvalidMethod => e
    pp e
    #   => #<Arachni::RPC::Exceptions::InvalidMethod: Trying to access non-public method 'does_not_exist'.>
end

begin
    # foo() expects an argument but arity is not checked so the call will be
    # forwarded to the remote object which will throw a remote exception
    bench.foo
rescue Arachni::RPC::Exceptions::RemoteException => e
    pp e
    #   => #<Arachni::RPC::Exceptions::RemoteException: wrong number of arguments (0 for 1)>
end

client = Arachni::RPC::Pure::Client.new(
    :host  => 'localhost',
    :port  => 7331,
    :token => 'invalidtoken',
    :serializer => Marshal
)

begin
    # the token is not valid so the remote server won't let us through
    client.call( 'bench.foo', 1 )
rescue Arachni::RPC::Exceptions::InvalidToken => e
    pp e
    #   => #<Arachni::RPC::Exceptions::InvalidToken: Token missing or invalid while calling: bench.foo>
end
