pub const RecommendationType = enum {
    standard,
    priority,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .priority = "PRIORITY",
    };
};
