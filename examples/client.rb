require_relative '../lib/arachni/rpc/pure'

dispatcher = Arachni::RPC::Pure::Client.new(
    host:  '127.0.0.1',
    port:  7331
)

instance_info = dispatcher.call( 'dispatcher.dispatch', 'The Dude' )
# => {
#         "token" => "1ac10910f41ce86e23ab954033b40a83",
#           "pid" => 27031,
#          "port" => 23496,
#           "url" => "127.0.0.1:23496",
#         "owner" => "The Dude",
#     "birthdate" => "2014-08-05 19:54:07 +0300",
#     "starttime" => "2014-08-05 19:54:58 +0300",
#       "helpers" => {}
# }

instance = Arachni::RPC::Pure::Client.new(
    host:  '127.0.0.1',
    port:  instance_info['port'],
    token: instance_info['token']
)

p instance.call( 'service.alive?' )
# => true

begin
    instance.call( 'service.scan' )
rescue => e
    # => #<RuntimeError: RemoteException: Option 'url' is mandatory.>
end

begin
    instance.call( 'service.error_test' )
rescue => e
    # => #<RuntimeError: RemoteException: wrong number of arguments (0 for 1)>
end

begin
    instance.call( 'service.blahblah' )
rescue => e
    # => #<RuntimeError: InvalidMethod: Trying to access non-public method 'blahblah'.>
end

begin
    instance.call( 'blahblah.stuff' )
rescue => e
    # => #<RuntimeError: InvalidObject: Trying to access non-existent object 'blahblah'.>
end
