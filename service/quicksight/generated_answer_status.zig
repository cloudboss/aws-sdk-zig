pub const GeneratedAnswerStatus = enum {
    answer_generated,
    answer_retrieved,
    answer_downgrade,

    pub const json_field_names = .{
        .answer_generated = "ANSWER_GENERATED",
        .answer_retrieved = "ANSWER_RETRIEVED",
        .answer_downgrade = "ANSWER_DOWNGRADE",
    };
};
