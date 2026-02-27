pub const QueryResultType = enum {
    document,
    question_answer,
    answer,

    pub const json_field_names = .{
        .document = "DOCUMENT",
        .question_answer = "QUESTION_ANSWER",
        .answer = "ANSWER",
    };
};
