pub const TimeSeriesGranularity = enum {
    all,
    specific,

    pub const json_field_names = .{
        .all = "ALL",
        .specific = "SPECIFIC",
    };
};
