/// Optional. When you request lists of resources, you can specify whether they
/// are sorted in ASCENDING or DESCENDING order. Default varies by resource.
pub const Order = enum {
    ascending,
    descending,

    pub const json_field_names = .{
        .ascending = "ASCENDING",
        .descending = "DESCENDING",
    };
};
