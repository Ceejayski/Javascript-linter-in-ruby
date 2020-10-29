class LinterCop
  attr_reader :file, :file_data, :error_msg, :file_reader, :file_name, :file_line

  def initialize(file)
    @file = file
    @file_name = File.basename(@file)
    @file_reader = File.read(@file)
    @file_data = @file_reader.split("\n")
    @file_line = File.new(@file).readlines
    @error_msg = []
  end

  def semicolon_check
    @file_data.each do |lines|
      line = @file_data.find_index(lines) + 1
      (@error_msg << "#{line} , Linter/beforeStatementContinuationChars: Missing semicolon(;) '#{lines.strip}'") unless ((lines.split('')) & ['{', '}','[','(',';']).any? || lines.empty?
    end
  end

  def trailing_space
    @file_data.each do |lines|
      line = @file_data.find_index(lines) + 1
     (@error_msg << "#{line} linter/layout: has an error of trailing space on '#{lines.strip}' ") if lines.split('')[-1] == ' '
    end
  end

  def parenthesis_check
    open_paren = 0
    unclosed = 0
    stack = []
    close_stack = []
    @file_data.each do |lines|
      line = @file_data.find_index(lines) + 1
      lines.split('').each do |str|
        case str
        when '{'
          open_paren += 1
          stack << line
        when '}'
          if open_paren.positive?
            open_paren -= 1
            stack.pop
          elsif open_paren.zero?
            unclosed += 1
            close_stack << line
          end
        end
      end
    end
    if open_paren.positive?
      stack.each do |x|
        @error_msg << "#{x} , Linter/beforeStatementContinuationChars:  Unclosed parenthensis ({) '#{@file_data[x - 1]}"
      end
    end
    if unclosed.positive?
      close_stack.each do |x|
        @error_msg << "#{x} , Linter/beforeStatementContinuationChars:  Unexpected (}) '#{@file_data[x - 1]}'"
      end
    end
  end

  def bracket_check
    open_paren = 0
    unclosed = 0
    stack = []
    close_stack = []
    @file_data.each do |lines|
      line = @file_data.find_index(lines) + 1
      lines.split('').each do |str|
        case str
        when '('
          open_paren += 1
          stack << line
        when ')'
          if open_paren.positive?
            open_paren -= 1
            stack.pop
          elsif open_paren.zero?
            unclosed += 1
            close_stack << line
          end
        end
      end
    end
    if open_paren.positive?
      stack.each do |x|
        @error_msg << "#{x} , Linter/beforeStatementContinuationChars: Unclosed bracket ( ( ) '#{@file_data[x - 1]}'"
      end
    end
    if unclosed.positive?
      close_stack.each do |x|
        @error_msg << "#{x} , Linter/beforeStatementContinuationChars: Unexpected ( ')' ) '#{@file_data[x - 1]}'"
      end
    end
  end

  def array_check
    open_paren = 0
    unclosed = 0
    stack = []
    close_stack = []
    @file_data.each do |lines|
      line = @file_data.find_index(lines) + 1
      lines.split('').each do |str|
        case str
        when '['
          open_paren += 1
          stack << line
        when ']'
          if open_paren.positive?
            open_paren -= 1
            stack.pop
          elsif open_paren.zero?
            unclosed += 1
            close_stack << line
          end
        end
      end
    end
    if open_paren.positive?
      stack.each do |x|
        @error_msg << "#{x} , Linter/beforeStatementContinuationChars: Unclosed array ([) '#{@file_data[x - 1]}'"
      end
    end
    if unclosed.positive?
      close_stack.each do |x|
        @error_msg << "#{x} , Linter/beforeStatementContinuationChars: Unexpected (]) '#{@file_data[x - 1]}'"
      end
    end
  end

  def check_classname
    @file_data.each do |lines|
      line = @file_data.find_index(lines) + 1
      lines.split(' ').each do |str|
        next unless str == 'class'

        index = lines.split(' ').find_index(str)
        class_name = lines.split(' ')[index + 1]
        first_letter = class_name[0]
        if first_letter != first_letter.capitalize || class_name.match(/[[^0-9A-Za-z{}()]]/) || !first_letter.is_a?(String)
          error_msg << "#{line} , Linter/Style: classname should contain be camel casing, must start with a string and must not contain any special character"
        end
      end
    end
  end

  def last_line_space_check
    # !~ /\S/
    last_line = @file_line.size
    @error_msg << "#{last_line} , linter/Layout: Missing end blank line" unless @file_line[-1].include?("\n") && file_line.size.positive?
    if @file_line[-1] == "\n" && @file_line.size > 0
      num = -1
      until @file_line[num] != "\n"
        @error_msg << "#{last_line + 1} , linter/Layout: Unexpected blank line"
        num -= 1
        last_line -= 1
      end
    end
  end

  def error_sort(array)
    error = array.sort_by{
        |s|
         s.scan(/\d+/).first.to_i
    }
    error
  end
end
