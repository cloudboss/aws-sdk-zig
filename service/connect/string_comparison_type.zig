pub const StringComparisonType = enum {
    starts_with,
    contains,
    exact,

    pub const json_field_names = .{
        .starts_with = "STARTS_WITH",
        .contains = "CONTAINS",
        .exact = "EXACT",
    };
};
