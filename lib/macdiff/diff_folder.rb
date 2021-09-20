require 'json'
class DiffFolder

  attr_accessor :folder1, :folder2
  attr_reader :output, :raw_output

  def initialize(folder1 ,folder2)
    @folder1 = File.expand_path(folder1, Dir.pwd)
    @folder2 = File.expand_path(folder2, Dir.pwd)
  end

  def run
    build_diff_output
    process_diff

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

  
  def process_diff
    details = []
    @raw_output.split("\n").each_with_index do |line, index| #.sort
      type = detect_comparison_type(line, index)

      detail = { 
        type: type,
        path: {}
          # type: :directory, :file
          # root_folder :
          # sub_folder
          # file
          # full_path
          # full_folder,
      }

      if type == :different
        # do something
      else
        set_path(line, index, type, detail)
      end

      # Only in /Users/davidcruwys/dev/cmdlets/macdiff/spec/samples/a: b
      # Only in /Users/davidcruwys/dev/cmdlets/macdiff/spec/samples/b: b1.txt
  
      details << detail
    end

    puts JSON.pretty_generate({ details: details })

    # puts lines


    # @output 
  end

  def build_diff_output
    @raw_output = IO.popen(command) do |f|
      f.read # or raise
    end
  end

  def detect_comparison_type(line, line_index)
    return :different if line.end_with?('differ')
    return :only_left if line.start_with?("Only in #{folder1}")
    return :only_right if line.start_with?("Only in #{folder2}")
    raise "Unknown comparison type at line: #{line_index+1}"
  end

  def set_path(line, line_index, type, detail)
    l = line.delete_prefix!("Only in ")
    
    raise "Prefix: Only in was not found on line #{line_index+1}" if l.nil?

    root_folder = type == :only_left ? folder1 : folder2

    l = line.delete_prefix!(root_folder)

    raise "Root folder was not found on line #{line_index+1} - #{root_folder}" if l.nil?
    

    # /Users/davidcruwys/dev/cmdlets/macdiff/spec/samples/a: b

    detail[:path] = {
      # type: :directory, :file
      root_folder: root_folder,
      fragment: l,

      # sub_folder: 
      # file
      # full_path
      # full_folder,
    }

  # /Users/davidcruwys/dev/cmdlets/macdiff/spec/samples/a/b       (is directory)
  # /Users/davidcruwys/dev/cmdlets/macdiff/spec/samples/b/b1.txt  (is file)
  # /Users/davidcruwys/dev/cmdlets/macdiff/spec/samples/b/c       (is directory)
  # Only in /Users/davidcruwys/dev/cmdlets/macdiff/spec/samples/a: b
  # Only in /Users/davidcruwys/dev/cmdlets/macdiff/spec/samples/b: b1.txt
  # Only in /Users/davidcruwys/dev/cmdlets/macdiff/spec/samples/b: c

  end

  def command
    @command ||= ["diff", "-rq", folder1, folder2]
  end
  
  # File.directory?("name") and/or File.file?("name")

  def sample
    <<-SAMPLE

    Only in /Users/davidcruwys/dev/cmdlets/macdiff/spec/samples/a: b
    Only in /Users/davidcruwys/dev/cmdlets/macdiff/spec/samples/b: b1.txt
    Only in /Users/davidcruwys/dev/cmdlets/macdiff/spec/samples/b: c
    Files /Users/davidcruwys/dev/cmdlets/macdiff/spec/samples/a/c1.txt and /Users/davidcruwys/dev/cmdlets/macdiff/spec/samples/b/c1.txt differ
    Files /Users/davidcruwys/dev/cmdlets/macdiff/spec/samples/a/x/g.txt and /Users/davidcruwys/dev/cmdlets/macdiff/spec/samples/b/x/g.txt differ
    Only in /Users/davidcruwys/dev/cmdlets/macdiff/spec/samples/b/x: h.txt
    Only in /Users/davidcruwys/dev/cmdlets/macdiff/spec/samples/b/y: z
    Only in /Users/davidcruwys/dev/cmdlets/macdiff/spec/samples/a: z

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