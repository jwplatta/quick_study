require 'json'

module QuickStudy
  class MarkdownToJSONConverter
    def initialize(markdown_file:, json_dir:)
      raise ArgumentError if markdown_file.nil? || json_dir.nil?

      @markdown_file = markdown_file
      @filename = File.basename(markdown_file, '.*')
      @json_dir = json_dir
    end

    attr_reader :markdown_file, :filename, :json_dir

    def convert
      topic, answers_questions = parse_topic_answers_questions(markdown_file.read)
      review_questions = build_review_questions(topic, answers_questions)
      json_file << build_json(topic, review_questions)
      json_file.close
      markdown_file.close
    end

    private

    attr_reader :markdown_files

    def parse_topic_answers_questions(file_text)
      markdown_text = file_text.split("\n").reject(&:empty?)

      unless markdown_text[0].start_with?('#')
        raise ArgumentError, 'File has no topic'
      end

      formatted_topic = markdown_text.shift.gsub('#', '').strip

      [formatted_topic, markdown_text]
    end

    def build_json(topic, review_questions)
      {
        set_title: topic,
        questions: review_questions.map(&:to_hash)
      }.to_json
    end

    def build_review_questions(topic, answers_questions)
      review_questions = []

      while answers_questions.count.positive?
        question_text = if answers_questions[0].start_with?('-')
                          text = answers_questions.shift
                          text[0] = ''
                          text.strip!
                        else
                          raise 'Missing question'
                        end

        answer_text = if !answers_questions[0].nil? && answers_questions[0].start_with?('answer:')
                        text = answers_questions.shift
                        text.gsub('answer:', '').strip!
                      else
                        'no answer'
                      end

        tags = if !answers_questions[0].nil? && answers_questions[0].start_with?('tags:')
          text = answers_questions.shift
          text = text.gsub('tags:', '').strip
          text.split(',').map(&:strip)
        else
          []
        end

        review_questions << build_review_question(topic, question_text, answer_text, tags)
      end

      review_questions
    end

    def build_review_question(topic, question_text, answer_text, tags)
      ReviewQuestion.new(
        topic: topic,
        question_text: question_text,
        answer_text: answer_text,
        tags: tags
      )
    end

    def json_file
      @json_file ||= File.open(json_dir + "/#{filename}.json", 'w')
    end
  end
end
