/// Enumeration of filter actions: KEEP to include log records, DROP to exclude
/// them.
pub const FilterBehavior = enum {
    keep,
    drop,

    pub const json_field_names = .{
        .keep = "KEEP",
        .drop = "DROP",
    };
};
