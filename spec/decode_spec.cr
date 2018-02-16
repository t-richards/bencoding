require "./spec_helper"
require "logger"

describe BEncoding do
  it "decodes strings" do
    BEncoding.decode("7:foo bar").should eq("foo bar")
    BEncoding.decode("0:").should eq("")
    BEncoding.decode("5:café").should eq("café")
  end

  it "decodes integers" do
    BEncoding.decode("i42e").should eq(42)
    BEncoding.decode("i0e").should eq(0)
    BEncoding.decode("i-42e").should eq(-42)
  end

  it "decodes lists" do
    BEncoding.decode("li1ei2ei3ee").should eq([1, 2, 3])
    BEncoding.decode("l6:你好6:中文e").should eq(["你好", "中文"])
  end

  it "decodes dictionaries" do
    BEncoding.decode("d3:bari-10e3:fooi1ee").should eq({"foo" => 1, "bar" => -10})
    BEncoding.decode("d3:foo3:bar3:baz3:quxe").should eq({"foo" => "bar", "baz" => "qux"})
  end

  fixtures_logger = Logger.new(File.new("#{__DIR__}/fixtures.log", "w"))
  Dir["#{__DIR__}/fixtures/*.torrent"].each do |fixture|
    it "decodes #{fixture}" do
      file = File.open(fixture)
      file.sync = true
      decoded = BEncoding.decode(file)
      fixtures_logger.info(decoded)
    end
  end
end
