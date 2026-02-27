pub const SortOrder = enum {
    /// ASCENDING
    ascending,
    /// DESCENDING
    descending,

    pub const json_field_names = .{
        .ascending = "ASCENDING",
        .descending = "DESCENDING",
    };
};
