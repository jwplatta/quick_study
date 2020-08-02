module QuickStudy
  class ReviewQuestion
    @question_count = 0

    class << self
      attr_accessor :question_count
    end

    attr_reader :topic, :question_text, :answer_text, :tags

    def initialize(**question_attributes)
      @topic = question_attributes.fetch(:topic)
      @question_text = question_attributes.fetch(:question_text)
      @answer_text = question_attributes.fetch(:answer_text)
      @tags = question_attributes.fetch(:tags, [])
    end

    def to_json
      JSON.generate(to_hash)
    end

    def to_hash
      {
        topic: topic,
        question_text: question_text,
        answer_text: answer_text,
        tags: tags
      }
    end
  end
end
