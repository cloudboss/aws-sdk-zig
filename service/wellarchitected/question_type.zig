pub const QuestionType = enum {
    prioritized,
    non_prioritized,

    pub const json_field_names = .{
        .prioritized = "PRIORITIZED",
        .non_prioritized = "NON_PRIORITIZED",
    };
};
