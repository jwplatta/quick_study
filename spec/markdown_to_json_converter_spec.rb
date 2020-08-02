RSpec.describe QuickStudy::MarkdownToJSONConverter do
  describe 'class methods' do
    context '.initialize' do
      it 'raises error when missing filename' do
        expect { QuickStudy::MarkdownToJSONConverter.new }.to raise_error(ArgumentError)
      end
      it 'does not raise error' do
        expect { QuickStudy::MarkdownToJSONConverter.new(markdown_file: 'test', json_dir: 'test') }.not_to raise_error
      end
    end
  end
  describe 'instance methods' do
    context '#convert_to_json' do
      let(:markfown_file_path) do
        File.expand_path('.') + '/spec/quick_study_dir/markdown/chapter_one.md'
      end

      let(:json_dir) do
        File.expand_path('.') + '/spec/quick_study_dir/json'
      end

      let(:json_file_path) do
        File.expand_path('.') + '/spec/quick_study_dir/json/chapter_one.json'
      end

      let(:expected_hash) do
        {
          'set_title' => '# Chapter 1',
          'questions' => [
            { 'topic' => '# Chapter 1',
              'question_text' => '- Question 1',
              'answer_text' => 'Answer 1',
              'tags' => [] },
            { 'topic' => '# Chapter 1',
              'question_text' => '- Question 2',
              'answer_text' => 'Answer 2',
              'tags' => [] }
          ]
        }
      end

      it 'correctly converts questions in markdown to json' do
        File.open(markfown_file_path, 'r') do |markdown_file|
          QuickStudy::MarkdownToJSONConverter.new(
            markdown_file: markdown_file,
            json_dir: json_dir
          ).convert
        end

        review_question_hash = File.open(json_file_path, 'r') do |json_file|
          JSON.parse(json_file.read)
        end

        expect(review_question_hash).to include(expected_hash)
      end
    end
  end
end
