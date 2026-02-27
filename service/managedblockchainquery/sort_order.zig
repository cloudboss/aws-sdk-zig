pub const SortOrder = enum {
    /// Result sorted in ascending order
    ascending,
    /// Result sorted in descending order
    descending,

    pub const json_field_names = .{
        .ascending = "ASCENDING",
        .descending = "DESCENDING",
    };
};
