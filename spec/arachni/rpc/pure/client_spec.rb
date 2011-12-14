require File.join( File.expand_path( File.dirname( __FILE__ ) ), '../../../', 'spec_helper' )

describe Arachni::RPC::Pure::Client do

    before( :all ) do
        @arg = [
            'one',
            2,
            { :three => 3 },
            [ 4 ]
        ]
    end

    describe "raw interface" do

        it "should be able to perform calls" do
            @arg.should == start_client( rpc_opts ).call( 'test.foo', @arg )
        end

    end

    describe "Arachni::RPC::RemoteObjectMapper interface" do

        it "should be able to properly forward calls" do
            test = Arachni::RPC::RemoteObjectMapper.new( start_client( rpc_opts ), 'test' )
            test.foo( @arg ).should == @arg
        end

    end

    describe "exception" do

        it "should be raised when requesting inexistent objects" do
            begin
                start_client( rpc_opts ).call( 'bar2.foo' )
            rescue Exception => e
                e.rpc_invalid_object_error?.should be_true
            end
        end

        it "should be raised when requesting inexistent or non-public methods" do
            begin
                start_client( rpc_opts ).call( 'test.bar2' )
            rescue Exception => e
                e.rpc_invalid_method_error?.should be_true
            end

        end

        it "should be raised when there's a remote exception" do
            begin
                start_client( rpc_opts ).call( 'test.foo' )
            rescue Exception => e
                e.rpc_remote_exception?.should be_true
            end
        end

    end

    it "should be able to retain stability and consistency under heavy load" do
        client = start_client( rpc_opts )

        n    = 1000
        cnt  = 0

        mismatches = []

        n.times {
            |i|
            client.call( 'test.foo', i ) {
                |res|

                cnt += 1

                mismatches << [i, res] if i != res
                break if cnt == n || !mismatches.empty?
            }
        }

        mismatches.should be_empty
    end

    it "should throw error when connecting to inexistent server" do
        begin
            start_client( rpc_opts.merge( :port => 9999 ) ).call( 'test.foo', @arg )
        rescue Exception => e
            e.rpc_connection_error?.should be_true
        end
    end

    context "when using valid SSL primitives" do
        it "should be able to establish a connection" do
            res = start_client( rpc_opts_with_ssl_primitives ).call( 'test.foo', @arg )
            res.should == @arg
        end
    end

    context "when using invalid SSL primitives" do
        it "should not be able to establish a connection" do
            begin
                start_client( rpc_opts_with_invalid_ssl_primitives ).call( 'test.foo', @arg )
            rescue Exception => e
                e.rpc_connection_error?.should be_true
            end
        end
    end

    context "when using mixed SSL primitives" do
        it "should not be able to establish a connection" do
            begin
                start_client( rpc_opts_with_mixed_ssl_primitives ).call( 'test.foo', @arg )
            rescue Exception => e
                e.rpc_connection_error?.should be_true
                e.rpc_ssl_error?.should be_true
            end
        end
    end

end
