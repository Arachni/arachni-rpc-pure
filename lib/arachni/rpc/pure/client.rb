=begin
                  Arachni-RPC
  Copyright (c) 2011 Tasos "Zapotek" Laskos <tasos.laskos@gmail.com>

  This is free software; you can copy and distribute and modify
  this program under the term of the GPL v2.0 License
  (See LICENSE file for details)

=end

module Arachni
module RPC
module Pure

class Client

    def initialize( opts )
        @opts = opts
    end

    def call( msg, *args )
        conn = Connection.new( @opts )
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
