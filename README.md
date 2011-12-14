# Arachni-RPC Pure
<table>
    <tr>
        <th>Version</th>
        <td>0.1</td>
    </tr>
    <tr>
        <th>Github page</th>
        <td><a href="http://github.com/Arachni/arachni-rpc-pure">http://github.com/Arachni/arachni-rpc-pure</a></td>
     <tr/>
    <tr>
        <th>Code Documentation</th>
        <td><a href="http://rubydoc.info/github/Arachni/arachni-rpc-pure/">http://rubydoc.info/github/Arachni/arachni-rpc-pure/</a></td>
    </tr>
    <tr>
       <th>Author</th>
       <td><a href="mailto:tasos.laskos@gmail.com">Tasos</a> "<a href="mailto:zapotek@segfault.gr">Zapotek</a>" <a href="mailto:tasos.laskos@gmail.com">Laskos</a></td>
    </tr>
    <tr>
        <th>Twitter</th>
        <td><a href="http://twitter.com/Zap0tek">@Zap0tek</a></td>
    </tr>
    <tr>
        <th>Copyright</th>
        <td>2011</td>
    </tr>
    <tr>
        <th>License</th>
        <td><a href="file.LICENSE.html">GNU General Public License v2</a></td>
    </tr>
</table>

## Synopsis

Arachni-RPC Pure is a simple implementation of a client for the <a href="http://github.com/Arachni/arachni-rpc-pure">Arachni-RPC</a> protocol.<br/>
It's written in pure Ruby using SSL sockets and does not have any 3rd party dependencies -- besides the Arachni-RPC spec itself.

## Usage

Check out the files in the <i>examples/</i> directory, they go through everything in great detail.

## Installation

### Gem

The Gem hasn't been pushed yet, the system is still under development.

### Source

If you want to clone the repository and work with the source code:

    git co git://github.com/arachni/arachni-rpc-pure.git
    cd arachni-rpc-pure
    rake install

## Running the Specs

In order to run the specs you must first fire up 2 sample servers although they are not part of this project -- as it is only a client implementation.<br/>
You can find the required servers in the [Arachni-RPC EM](https://github.com/Arachni/arachni-rpc-em) project.

From inside the Arachni-RPC EM directory run:

    ruby spec/servers/basic.rb
    ruby spec/servers/with_ssl_primitives.rb

Then, from inside the directory of Arachni-RPC Pure:

    rake spec

## Bug reports/Feature requests
Please send your feedback using Github's issue system at
[http://github.com/arachni/arachni-rpc-pure/issues](http://github.com/arachni/arachni-rpc-pure/issues).


## License
Arachni is licensed under the GNU General Public License v2.<br/>
See the [LICENSE](file.LICENSE.html) file for more information.

