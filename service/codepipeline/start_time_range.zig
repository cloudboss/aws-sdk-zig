pub const StartTimeRange = enum {
    latest,
    all,

    pub const json_field_names = .{
        .latest = "Latest",
        .all = "All",
    };
};
