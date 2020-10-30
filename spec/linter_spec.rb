require_relative '../lib/linter_cops.rb'
describe 'LinterCop' do
    let(:lint_spec) { LinterCop.new('test/test2.js') }

    it "#check_if_file_is_empty" do
        expect(lint_spec.empty_file?).to eql(false)
    end

    it "#check_missing_semi_colon" do
        lint_spec.semicolon_check
        expect(lint_spec.error_msg[0][0]).to eql("5")
    end

    it "#check_trailing_space" do
        lint_spec.trailing_space
        expect(lint_spec.error_sort(lint_spec.error_msg)[0][0]).to eql("4")
    end
    it "#check_for_balanced_parenthesis" do
        lint_spec.parenthesis_check
        expect(lint_spec.error_sort(lint_spec.error_msg)[0]).to eql("23 , Linter/beforeStatementContinuationChars:  Unexpected (}) '{}{}}'")
    end
    it "#check_for_balanced_bracket" do
        lint_spec.bracket_check
        expect(lint_spec.error_sort(lint_spec.error_msg)[0]).to eql("24 , Linter/beforeStatementContinuationChars: Unclosed bracket ( ( ) '()('")
    end
    it "#check_for_balanced_angle_bracket" do
        lint_spec.array_check
        expect(lint_spec.error_sort(lint_spec.error_msg)[0]).to eql("25 , Linter/beforeStatementContinuationChars: Unclosed array ([) '['")
    end
    it "#check_for_valid_classname" do
        lint_spec.check_classname
        expect(lint_spec.error_sort(lint_spec.error_msg)[0][0]).to eql("1")
    end
    it "#check_blank_last_line" do
        lint_spec.last_line_space_check
        expect(lint_spec.error_sort(lint_spec.error_msg)[0]).to eql("27 , linter/Layout: Unexpected blank line")
    end
    it "#sort_error_array_according_to_fileline" do
        expect(lint_spec.error_sort(["9","2","3","7","4","9","8","5","2"])).to eql(["2", "2", "3", "4", "5", "7", "8", "9", "9"])
    end
end