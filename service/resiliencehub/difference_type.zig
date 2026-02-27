pub const DifferenceType = enum {
    not_equal,
    added,
    removed,

    pub const json_field_names = .{
        .not_equal = "NOT_EQUAL",
        .added = "ADDED",
        .removed = "REMOVED",
    };
};
