pub const FilterBehavior = enum {
    keep,
    drop,

    pub const json_field_names = .{
        .keep = "KEEP",
        .drop = "DROP",
    };
};
