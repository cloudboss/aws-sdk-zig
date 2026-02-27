pub const EvaluationTaskType = enum {
    summarization,
    classification,
    question_and_answer,
    generation,
    custom,

    pub const json_field_names = .{
        .summarization = "SUMMARIZATION",
        .classification = "CLASSIFICATION",
        .question_and_answer = "QUESTION_AND_ANSWER",
        .generation = "GENERATION",
        .custom = "CUSTOM",
    };
};
