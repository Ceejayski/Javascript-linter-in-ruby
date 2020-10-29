class LinterCop
    attr_reader :file, :file_data, :error_msg, :file_reader, :file_name
    
    def initialize(file)
        @file = file
        @file_name = File.basename(@file)
        @file_reader = File.open(@file)
        @file_data = @file_reader.read.split("\n")
        @error_msg = {}
    end

    def semicolon_check
        @file_data.each{|lines|
            line = (@file_data.find_index(lines)) + 1
            @error_msg[line] = ("line #{line} of #{@file_name} has Missing semicolon(;) ( '#{lines.strip}' )") if !(((lines.split("")) & ["{", "}", ";"]).any? || lines.empty?)
        }
    end

    def trailing_space
        @file_data.each{
            |lines|
            line = (@file_data.find_index(lines)) + 1
            @error_msg[line] = ( "line #{line} of #{@file_name} has an error of trailing space on ( '#{lines.strip}' )" )if lines.split("")[-1] == " "
        }
    end

    def parenthesis_check
        open_paren = 0
        unclosed = 0 
        stack = []
        close_stack = []
        @file_data.each{
            |lines|
            line = (@file_data.find_index(lines)) + 1
            lines.split("").each{
                |str|
                if str == "{"
                    open_paren += 1
                    stack << line
                elsif str == "}"
                    if open_paren > 0
                        open_paren -= 1
                        stack.pop()
                    elsif open_paren == 0
                        unclosed += 1
                        close_stack << line
                    end
                end
            }
        }
        if open_paren > 0
            stack.each{
                |x|
                @error_msg[x] = ("line #{x} of #{file_name} '#{@file_data[x - 1]}' has an unclosed object ({)")
            }
        end
        if unclosed > 0
            close_stack.each{
                |x|
                @error_msg[x] = ("line #{x} of #{file_name} '#{@file_data[x-1]}' has an unexpected }")
            }
        end
    end
    def bracket_check
        open_paren = 0
        unclosed = 0 
        stack = []
        close_stack = []
        @file_data.each{
            |lines|
            line = (@file_data.find_index(lines)) + 1
            lines.split("").each{
                |str|
                if str == "("
                    open_paren += 1
                    stack << line
                elsif str == ")"
                    if open_paren > 0
                        open_paren -= 1
                        stack.pop()
                    elsif open_paren == 0
                        unclosed += 1
                        close_stack << line
                    end
                end
            }
        }
        if open_paren > 0
            stack.each{
                |x|
                @error_msg[x] = ("line #{x} of #{file_name} '#{@file_data[x - 1]}' has an unclosed bracket '(' ")
            }
        end
        if unclosed > 0
            close_stack.each{
                |x|
                @error_msg[x] = ("line #{x} of #{file_name} '#{@file_data[x-1]}' has an unexpected )")
            }
        end
    end

    def array_check
        open_paren = 0
        unclosed = 0 
        stack = []
        close_stack = []
        @file_data.each{
            |lines|
            line = (@file_data.find_index(lines)) + 1
            lines.split("").each{
                |str|
                if str == "["
                    open_paren += 1
                    stack << line
                elsif str == "]"
                    if open_paren > 0
                        open_paren -= 1
                        stack.pop()
                    elsif open_paren == 0
                        unclosed += 1
                        close_stack << line
                    end
                end
            }
        }
        if open_paren > 0
            stack.each{
                |x|
                @error_msg[x] = ("line #{x} of #{file_name} '#{@file_data[x - 1]}' has an unclosed array ([)")
            }
        end
        if unclosed > 0
            close_stack.each{
                |x|
                @error_msg[x] = ("line #{x} of #{file_name} '#{@file_data[x-1]}' has an unexpected (])")
            }
        end
    end

    def check_classname
        @file_data.each{
            |lines|
            line = (@file_data.find_index(lines)) + 1
            lines.split(" ").each{
                |str|
                if str == "class"
                    index = lines.split(" ").find_index(str)
                    class_name = lines.split(" ")[index + 1]
                    first_letter = class_name[0]
                    if first_letter != first_letter.capitalize || class_name.match(/[[^0-9A-Za-z{}()]]/) || !first_letter.is_a?(String)
                        error_msg[line] = "Line #{line} of #{file_name} classname( #{class_name} ) should contain be in camel casing, must start with a string and must not contain any special character"
                    end
                end
            }
        }
    end
    def error_sort
        errors = @error_msg.sort.to_h
        errors
    end
end