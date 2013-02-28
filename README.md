Config File Reader
==================

This is a simple class that will read a config file and make the values accessible as a hash.

### Supported config file format ###
```
# This is a comment, ignore it

host = test.com

user = user

# More comments

log_file_path = /tmp/logfile.log

verbose = true

test_mode = on
```

### Usage example ###
```ruby
appConfig = ConfigReader.new('my_config_file.txt')

verbose_mode = appConfig['verbose']

puts verbose_mode # Prints 'true' given the example config file above
```

### Running the tests ###

Make sure you have rspec installed with `gem install rspec`.

```
$ rspec --color config_reader_spec.rb
..........

Finished in 0.00358 seconds
10 examples, 0 failures

```