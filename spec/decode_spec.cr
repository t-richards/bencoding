require "./spec_helper"
require "logger"

describe Bencoding do
  it "handles empty io" do
    expect_raises Bencoding::DecodeError do
      Bencoding.decode("")
    end
  end

  it "decodes strings" do
    Bencoding.decode("7:foo bar").should eq("foo bar")
    Bencoding.decode("0:").should eq("")
    Bencoding.decode("5:café").should eq("café")
  end

  it "decodes integers" do
    Bencoding.decode("i42e").should eq(42)
    Bencoding.decode("i0e").should eq(0)
    Bencoding.decode("i-42e").should eq(-42)
  end

  it "handles invalid integers" do
    expect_raises Bencoding::DecodeError do
      Bencoding.decode("i")
    end
  end

  it "decodes lists" do
    Bencoding.decode("li1ei2ei3ee").should eq([1, 2, 3])
    Bencoding.decode("l6:你好6:中文e").should eq(["你好", "中文"])
  end

  it "decodes dictionaries" do
    Bencoding.decode("d3:bari-10e3:fooi1ee").should eq({"foo" => 1, "bar" => -10})
    Bencoding.decode("d3:foo3:bar3:baz3:quxe").should eq({"foo" => "bar", "baz" => "qux"})
  end

  it "decodes file" do
    Bencoding.load_file("#{__DIR__}/fixtures/alice.torrent").should_not eq(nil)
  end

  it "handles invalid dictionaries" do
    expect_raises Bencoding::DecodeError do
      Bencoding.decode("d3")
    end
    expect_raises Bencoding::DecodeError do
      Bencoding.decode("d9")
    end
  end

  fixtures_logger = Logger.new(File.new("#{__DIR__}/fixtures.log", "w"))
  Dir["#{__DIR__}/fixtures/*.torrent"].each do |fixture|
    it "decodes #{fixture}" do
      file = File.open(fixture)
      file.sync = true
      decoded = Bencoding.decode(file)
      fixtures_logger.info(decoded)
    end
  end
end
