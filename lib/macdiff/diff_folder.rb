class DiffFolder

  attr_accessor :folder1, :folder2
  attr_reader :output, :raw_output

  def initialize(folder1 ,folder2)
    @folder1 = File.expand_path(folder1, Dir.pwd)
    @folder2 = File.expand_path(folder2, Dir.pwd)
  end

  def run
    @raw_output = IO.popen(command) do |f|
      f.read # or raise
    end

    # NOT WORK, need to investigate
    # puts $?.success?
    # puts $?.exitstatus
    # $?.exitstatus == 0 || raise
  end

  def debug
    puts '-' * 70
    puts command.join(' ')
    puts '-' * 70
    puts @raw_output
    puts '-' * 70
  end

  private

  def command
    @command ||= ["diff", "-rq", folder1, folder2]
  end
  

  def sample
    <<-SAMPLE

    Only in /Users/davidcruwys/dev/cmdlets/macdiff/spec/samples/a: b
    Only in /Users/davidcruwys/dev/cmdlets/macdiff/spec/samples/b: b1.txt
    Only in /Users/davidcruwys/dev/cmdlets/macdiff/spec/samples/b: c
    Files /Users/davidcruwys/dev/cmdlets/macdiff/spec/samples/a/c1.txt and /Users/davidcruwys/dev/cmdlets/macdiff/spec/samples/b/c1.txt differ
    Files /Users/davidcruwys/dev/cmdlets/macdiff/spec/samples/a/x/g.txt and /Users/davidcruwys/dev/cmdlets/macdiff/spec/samples/b/x/g.txt differ
    Only in /Users/davidcruwys/dev/cmdlets/macdiff/spec/samples/b/x: h.txt
    false
    false
    
    SAMPLE

  end

  #  # need to use some sort of caching folder for this
  #  ext = File.extname(file)
  #  fn  = File.basename(file, ext)
  #  temp_file = Tempfile.new([fn, ext])

  #  temp_file.write(content)
  #  temp_file.close

  #  return if File.read(file) == content

  #  system("code -d #{file} #{temp_file.path}")
  #  sleep 2
  
end