pub const ReturnItemCollectionMetrics = enum {
    size,
    none,

    pub const json_field_names = .{
        .size = "SIZE",
        .none = "NONE",
    };
};
