pub const RelevanceType = enum {
    relevant,
    not_relevant,

    pub const json_field_names = .{
        .relevant = "RELEVANT",
        .not_relevant = "NOT_RELEVANT",
    };
};
