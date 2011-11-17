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

class Connection

    def initialize( opts )
        @opts = opts

        socket = TCPSocket.new( opts[:host], opts[:port] )

        @ssl_context = OpenSSL::SSL::SSLContext.new

        if opts[:ssl_cert] && opts[:ssl_pkey]
            @ssl_context.cert = OpenSSL::X509::Certificate.new( File.open( opts[:ssl_cert] ) )
            @ssl_context.key = OpenSSL::PKey::RSA.new( File.open( opts[:ssl_pkey] ) )
            @ssl_context.verify_mode =
                OpenSSL::SSL::VERIFY_PEER | OpenSSL::SSL::VERIFY_FAIL_IF_NO_PEER_CERT
        end

        @ssl_socket = OpenSSL::SSL::SSLSocket.new( socket, @ssl_context )
        @ssl_socket.sync_close = true
        @ssl_socket.connect
    end

    def close
        @ssl_socket.close
    end

    def perform( request )
        Response.new( send_rcv_object( request.prepare_for_tx ) )
    end


    private

    def send_rcv_object( obj )
        send_object( obj )
        receive_object
    end

    def send_object( obj )
        serialized = serializer.dump( obj )
        @ssl_socket.puts( [ serialized.bytesize, serialized ].pack( 'Na*' ) )
    end

    def receive_object
        while data = @ssl_socket.sysread( 99999 )
            (@buf ||= '') << data
            while @buf.size >= 4
                if @buf.size >= 4 + ( size = @buf.unpack( 'N' ).first )
                    @buf.slice!(0,4)

                    complete = @buf.slice!( 0, size )
                    @buf = ''
                    return serializer.load( complete )
                else
                    break
                end
            end
        end
    end

    private

    def serializer
        @opts[:serializer] ? @opts[:serializer] : Marshal
    end


end

end
end
end
