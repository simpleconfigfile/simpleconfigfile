# config_reader_spec.rb
require 'config_reader'

describe ConfigReader do
  before do
    @config = ConfigReader.new(File.join('test_data', 'sample_config.txt'))
  end

  describe "#strip_comments" do
    it "should strip comments" do
      line = @config.send(:strip_comments, "# This is a comment, ignore it")
      line.should == ""
    end

    it "should not strip other text" do
      line = @config.send(:strip_comments, "key = value")
      line.should == "key = value"
    end

    it "should strip comments mid-line" do
      line = @config.send(:strip_comments, "key = value # This is a comment, ignore it")
      line.should == "key = value "
    end
  end

  describe "#convert_booleans" do
    it "should convert 'true' to true" do
      line = @config.send(:convert_booleans, "true")
      line.should == true
    end

    it "should convert 'false' to false" do
      line = @config.send(:convert_booleans, "false")
      line.should == false
    end

    it "should not convert non-boolean values" do
      line = @config.send(:convert_booleans, "123")
      line.should == "123"
    end
  end

  describe "parsing config files" do
    it "should make config options accessible in code, via their name" do
      @config['host'].should == 'test.com'
      @config['user'].should == 'user'
      @config['test_mode'].should == 'on'
      @config['log_file_path'].should == '/tmp/logfile.log'
    end

    it "should return boolean config options as real booleans" do
      @config['verbose'].should == true
      @config['concise'].should == false
    end

    it "should handle multiple = signs in one line" do
      @config['test'].should == "my = value"
    end
  end

  describe "parsing invalid config files" do
    it "should throw a 'file not found' exception if the config file doesn't exist" do
      expect { @config = ConfigReader.new('fake_fake.fake') }.to raise_error(Errno::ENOENT)
    end
  end
end