const GeneratedAnswerStatus = @import("generated_answer_status.zig").GeneratedAnswerStatus;

/// The QA result that is made from generated answer.
pub const GeneratedAnswerResult = struct {
    /// The ID of the answer.
    answer_id: ?[]const u8 = null,

    /// The answer status of the generated answer.
    answer_status: ?GeneratedAnswerStatus = null,

    /// The ID of the question.
    question_id: ?[]const u8 = null,

    /// The question text.
    question_text: ?[]const u8 = null,

    /// The URL of the question.
    question_url: ?[]const u8 = null,

    /// The restatement for the answer.
    restatement: ?[]const u8 = null,

    /// The ID of the topic.
    topic_id: ?[]const u8 = null,

    /// The name of the topic.
    topic_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .answer_id = "AnswerId",
        .answer_status = "AnswerStatus",
        .question_id = "QuestionId",
        .question_text = "QuestionText",
        .question_url = "QuestionUrl",
        .restatement = "Restatement",
        .topic_id = "TopicId",
        .topic_name = "TopicName",
    };
};
