RSpec.describe QuickStudy::ReviewQuestion do
  let(:question_attrs) do
    {
      topic: 'chapter 2',
      question_text: 'question?',
      answer_text: 'answer',
      tags: ['pg 123']
    }
  end

  describe 'class methods' do
    describe '.new' do
      context 'when given complete question attributes' do
        it 'does not error' do
          expect { QuickStudy::ReviewQuestion.new(question_attrs) }.not_to raise_error
        end
      end
      context 'when not passed any question attributes' do
        it 'raises error' do
          expect { QuickStudy::ReviewQuestion.new({}) }.to raise_error(KeyError)
        end
      end
    end
    context '.question_count' do
      it 'starts at zero' do
        expect(QuickStudy::ReviewQuestion.question_count).to eq 0
      end
    end
  end

  describe 'instance methods' do
    describe '#to_json' do
      let(:json_schema) do
        {
          "$schema": 'http://json-schema.org/draft-04/schema#',
          "type": 'object',
          "properties": {
            "topic": {
              "type": 'string'
            },
            "question_text": {
              "type": 'string'
            },
            "answer_text": {
              "type": 'string'
            },
            "tags": {
              "type": 'array',
              "items": [
                {
                  "type": 'string'
                }
              ]
            }
          },
          "required": %w[
            topic
            question_text
            answer_text
            tags
          ]
        }
      end
      it 'returns correct json format' do
        question_json = QuickStudy::ReviewQuestion.new(question_attrs).to_json
        expect(JSON::Validator.validate(json_schema, question_json)).to be true
      end
    end
    describe '#to_hash' do
    end
  end
end
