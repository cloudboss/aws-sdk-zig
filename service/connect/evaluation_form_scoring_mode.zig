pub const EvaluationFormScoringMode = enum {
    question_only,
    section_only,

    pub const json_field_names = .{
        .question_only = "QUESTION_ONLY",
        .section_only = "SECTION_ONLY",
    };
};
