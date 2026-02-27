pub const RouteNoticeImpact = enum {
    high,
    low,

    pub const json_field_names = .{
        .high = "HIGH",
        .low = "LOW",
    };
};
