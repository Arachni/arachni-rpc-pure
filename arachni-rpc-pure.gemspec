=begin

    This file is part of the Arachni-RPC Pure project and may be subject to
    redistribution and commercial restrictions. Please see the Arachni-RPC Pure
    web site for more information on licensing and terms of use.

=end

Gem::Specification.new do |s|
      require File.expand_path( File.dirname( __FILE__ ) ) + '/lib/arachni/rpc/pure/version'

      s.name              = "arachni-rpc-pure"
      s.version           = Arachni::RPC::Pure::VERSION
      s.date              = Time.now.strftime('%Y-%m-%d')
      s.summary           = "Pure Ruby client for Arachni-RPC."
      s.homepage          = "https://github.com/Arachni/arachni-rpc-pure"
      s.email             = "tasos.laskos@arachni-scanner.com"
      s.authors           = [ "Tasos Laskos" ]

      s.files             = %w( README.md Rakefile LICENSE.md CHANGELOG.md )
      s.files            += Dir.glob("lib/**/**")
      s.files            += Dir.glob("examples/**/**")
      s.test_files        = Dir.glob("examples/**/**")
      s.test_files       += Dir.glob("spec/**/**")

      s.extra_rdoc_files  = %w( README.md LICENSE.md CHANGELOG.md )
      s.rdoc_options      = ["--charset=UTF-8"]

      s.add_dependency 'msgpack'

      s.description = <<description
        Pure Ruby client implementation of the Arachni-RPC protocol.
description
end
