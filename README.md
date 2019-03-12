# Bendy

Bendy is a tiny mocking framework.

## Install

	$ curl -o lib/bendy.rb https://raw.github.com/Manfred/Bendy/master/bendy.rb

## Examples

Mock object that responds to a couple of methods.

```ruby
henry = shape(name: "Henry")
henry.name #=> "Henry"
```

Wrap a class definition and override a couple of methods.

```ruby
class Weblog
  def author
    "Henry"
  end

  def path
    "/path/to/weblog"
  end
end

weblog = shape(Weblog,
  path: "/mnt/data/weblog",
  reverse: Proc.new { |s| s.reverse }
)
weblog.path #=> "/mnt/data/weblog"
weblog.author #=> "Henry"
weblog.reverse('Jimmy') #=> 'ymmiJ"
```

Initialize a shape with arguments.

```ruby
class Weblog
  attr_reader :path

  def initialize(path)
    @path = path
  end
end

weblog = shape(Weblog, "/mnt/data/weblog", author: "Henry")
weblog.path #=> "/mnt/data/weblog"
weblog.author #=> "Henry"
```

## Copying

Bendy is freely distributable under the terms of an MIT-style license. See COPYING or http://www.opensource.org/licenses/mit-license.php.

-----

“Ik wil alleen maar benden.”