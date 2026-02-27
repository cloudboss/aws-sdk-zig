pub const ModelCardSortOrder = enum {
    ascending,
    descending,

    pub const json_field_names = .{
        .ascending = "ASCENDING",
        .descending = "DESCENDING",
    };
};
