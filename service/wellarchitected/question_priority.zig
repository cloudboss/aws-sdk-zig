pub const QuestionPriority = enum {
    prioritized,
    none,

    pub const json_field_names = .{
        .prioritized = "PRIORITIZED",
        .none = "NONE",
    };
};
