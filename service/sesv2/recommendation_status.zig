pub const RecommendationStatus = enum {
    open,
    fixed,

    pub const json_field_names = .{
        .open = "OPEN",
        .fixed = "FIXED",
    };
};
