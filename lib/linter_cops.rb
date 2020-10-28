class LinterCop
    attr_reader :file, :file_data, :error_msg, :file_reader, :file_name
    
    def initialize(file)
        @file = file
        @file_name = File.basename(@file)
        @file_reader = File.open(@file)
        @file_data = @file_reader.read.split("\n")
        @error_msg = []
    end

    def semicolon_check
        @file_data.each{|lines|
            line = @file_data.find_index(lines)
            @error_msg << ("Missing semicolon(;) at line #{line} #{lines.strip} of #{@file_name}") if !(((lines.split("")) & ["{", "}", ";"]).any? || lines.empty?)
        }
    end


    
end