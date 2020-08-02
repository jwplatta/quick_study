module QuickStudy
  class MarkdownToJSONConverter
    def initialize(markdown_file:, json_dir:)
      raise ArgumentError if markdown_file.nil? || json_dir.nil?

      @markdown_file = markdown_file
      @filename = File.basename(markdown_file, '.*')
      @json_dir = json_dir

      # TODO: move to rake task
      # @markdown_files = Dir.glob(markdown_dir + '/*').map do |file_name|
      #   [File.basename(file_name, '.*'), File.open(file_name, 'r')]
      # end.to_h
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

      [markdown_text.shift, markdown_text]
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
        question_text = answers_questions.shift
        answer_text = if answers_questions.empty? || answers_questions[0].start_with?('-')
                        'no answer'
                      else
                        answers_questions.shift
                      end
        review_questions << build_review_question(topic, question_text, answer_text)
      end

      review_questions
    end

    def build_review_question(topic, question_text, answer_text)
      ReviewQuestion.new(
        topic: topic,
        question_text: question_text,
        answer_text: answer_text
      )
    end

    def json_file
      @json_file ||= File.open(json_dir + "/#{filename}.json", 'w')
    end
  end
end
