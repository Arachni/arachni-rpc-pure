=begin

    This file is part of the Arachni-RPC Pure project and may be subject to
    redistribution and commercial restrictions. Please see the Arachni-RPC EM
    web site for more information on licensing and terms of use.

=end

module Arachni
module RPC
module Pure

class Client

    def initialize( opts )
        @opts = opts
    end

    def call( msg, *args )
        conn = nil
        begin
            conn = Connection.new( @opts )
        rescue OpenSSL::SSL::SSLError => ex
            e = Arachni::RPC::Exceptions::SSLPeerVerificationFailed.new( ex.to_s )
            e.set_backtrace( ex.backtrace )
            raise e
        rescue Errno::ECONNREFUSED => ex
            e = Arachni::RPC::Exceptions::ConnectionError.new( ex.to_s )
            e.set_backtrace( ex.backtrace )
            raise e
        end

        response = conn.perform( request( msg, *args ) )
        conn.close

        handle_exception( response )
        return response.obj
    end

    private

    def handle_exception( response )
        if exception?( response )
            raise Arachni::RPC::Exceptions.from_response( response )
        end
    end

    def exception?( response )
        response.obj.is_a?( Hash ) && response.obj.include?( 'exception' )
    end

    def request( msg, *args )
        Request.new(
            :message  => msg,
            :args     => args,
            :token    => @opts[:token]
        )
    end

end

end
end
end
