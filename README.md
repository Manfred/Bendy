# Bendy

Bendy is a tiny mocking framework.

## Examples

Basic mock implementation which responds to methods.

	henry = shape(:name => "Henry")
	henry.name #=> "Henry"

Mock implementation of a number of methods.

	class Weblog
	  def author
	  	"Henry"
	  end
	  
	  def path
	  	"/path/to/weblog"
	  end
	end
	
	weblog = shape(Weblog,
	  :path => "/mnt/data/weblog",
	  :reverse => Proc.new { |s| s.reverse }
	)
	weblog.path #=> "/mnt/data/weblog"
	weblog.author #=> "Henry"
	weblog.reverse('Jimmy') #=> 'ymmiJ"

Finally you can also pass arguments to the initializer.

    class Weblog
      attr_reader :path
      
      def initialize(path)
        @path = path
      end
    end
    
	weblog = shape(Weblog, "/mnt/data/weblog", :author => "Henry")
	weblog.path #=> "/mnt/data/weblog"
	weblog.author #=> "Henry"

## Copying

Bendy is freely distributable under the terms of an MIT-style license. See COPYING or http://www.opensource.org/licenses/mit-license.php.

-----

“Ik wil alleen maar benden.”