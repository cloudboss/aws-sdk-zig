pub const SortKey = enum {
    descending,
    ascending,

    pub const json_field_names = .{
        .descending = "DESCENDING",
        .ascending = "ASCENDING",
    };
};
