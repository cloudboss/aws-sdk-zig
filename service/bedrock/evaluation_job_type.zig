pub const EvaluationJobType = enum {
    human,
    automated,

    pub const json_field_names = .{
        .human = "HUMAN",
        .automated = "AUTOMATED",
    };
};
