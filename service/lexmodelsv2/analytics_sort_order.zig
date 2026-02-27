pub const AnalyticsSortOrder = enum {
    ascending,
    descending,

    pub const json_field_names = .{
        .ascending = "Ascending",
        .descending = "Descending",
    };
};
