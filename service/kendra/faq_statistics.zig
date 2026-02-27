/// Provides statistical information about the FAQ questions and answers for an
/// index.
pub const FaqStatistics = struct {
    /// The total number of FAQ questions and answers for an index.
    indexed_question_answers_count: i32 = 0,

    pub const json_field_names = .{
        .indexed_question_answers_count = "IndexedQuestionAnswersCount",
    };
};
