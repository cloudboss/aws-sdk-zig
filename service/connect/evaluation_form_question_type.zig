pub const EvaluationFormQuestionType = enum {
    text,
    singleselect,
    numeric,
    multiselect,
    datetime,

    pub const json_field_names = .{
        .text = "TEXT",
        .singleselect = "SINGLESELECT",
        .numeric = "NUMERIC",
        .multiselect = "MULTISELECT",
        .datetime = "DATETIME",
    };
};
