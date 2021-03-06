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

  def empty_file?
    @file_reader.split(' ').empty?
  end

  def semicolon_check
    @file_data.each do |lines|
      line = @file_data.find_index(lines) + 1
      unless ['{', '}', '[', '(', ';'].include?(lines.gsub(/\s+/, '')[-1]) || lines.include?('class') || lines.empty?
        (@error_msg << "#{line} , Linter/beforeStatementContinuationChars: Missing semicolon(;) '#{lines.strip}'")
      end
    end
  end

  def trailing_space
    @file_data.each do |lines|
      line = @file_data.find_index(lines) + 1
      (@error_msg << "#{line} linter/layout: has an error of trailing space on '#{lines.strip}' ") if lines.split('')[-1] == ' '
    end
  end

  def parenthesis_check(opening_tag, closing_tag)
    open_paren = 0
    unclosed = 0
    stack = []
    close_stack = []
    @file_data.each do |lines|
      line = @file_data.find_index(lines) + 1
      lines.split('').each do |str|
        case str
        when opening_tag
          open_paren += 1
          stack << line
        when closing_tag
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
        @error_msg << "#{x} , Linter/beforeStatementContinuationChars:  Unclosed parenthensis '#{opening_tag}'"
      end
    end
    return unless unclosed.positive?

    close_stack.each do |x|
      @error_msg << "#{x} , Linter/beforeStatementContinuationChars:  Unexpected '#{closing_tag}'"
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
        if first_letter != first_letter.capitalize || class_name.match(/[[^0-9A-Za-z{}()]]/) || first_letter.to_i != 0 || first_letter == '0'
          error_msg << "#{line} , Linter/Style: classname should contain be camel casing, must start with a string and must not contain any special character"
        end
      end
    end
  end

  def last_line_space_check
    last_line = @file_line.size
    @error_msg << "#{last_line} , linter/Layout: Missing end blank line" unless @file_line[-1].include?("\n") && file_line.size.positive?
    return unless @file_line[-1] == "\n" && @file_line.size.positive?

    num = -1
    until @file_line[num] != "\n"
      @error_msg << "#{last_line + 1} , linter/Layout: Unexpected blank line"
      num -= 1
      last_line -= 1
    end
  end

  def error_sort(array)
    array.sort_by do |s|
      s.scan(/\d+/).first.to_i
    end
  end
end
