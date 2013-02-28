class ConfigReader

  def initialize(filename)
    @config = {}
    parse(filename)
  end

  # Provide a simple interface to a config object where config keys
  # are accessible with a simple config['key_name'] syntax.
  #
  # You could also make keys accessible as functions using
  # 'define_method', but that seems like overkill and could have
  # security implications if implemented poorly and you were reading
  # untrusted config files.
  def [](key)
    @config[key]
  end

  # The rest of this code is not part of the object's interface
  # and isn't meant to be called directly, so make it private.
  private

  def parse(filename)
    # Loop through the config file, handling each line separately
    File.open(filename, "r").each_line{|line| parse_line(line) }
  end

  # Handle one line of the config file
  def parse_line(line)
    # Remove comment text
    line = strip_comments(line)

    # Read key/value pair if one exists in this line
    (key, value) = line.split("=", 2)

    if key && value
      # Remove any extra whitespace or line endings
      # and handle any type boolean type conversions
      key = key.strip
      value = convert_booleans(value.strip)

      # Save the configuration values in a hash
      @config[key] = value
    end
  end

  # Stripping comments from a line is a separate piece of logic,
  # so make it a separate function that is easy to test
  def strip_comments(line)
    if line.include?('#')
      line.split("#", 2)[0]
    else
      line
    end
  end

  # Boolean conversion is a separate piece of logic,
  # so make it a separate function that is easy to test
  def convert_booleans(value)
    if ["true", "false"].include?(value)
      value = (value == "true")
    else
      value
    end
  end

end