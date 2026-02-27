pub const RuleExecutionMode = enum {
    all_matched,
    first_matched,

    pub const json_field_names = .{
        .all_matched = "ALL_MATCHED",
        .first_matched = "FIRST_MATCHED",
    };
};
