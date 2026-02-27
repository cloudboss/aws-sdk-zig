pub const Relevance = enum {
    helpful,
    not_helpful,

    pub const json_field_names = .{
        .helpful = "HELPFUL",
        .not_helpful = "NOT_HELPFUL",
    };
};
