/// A filter for reference stores.
pub const ReferenceStoreFilter = struct {
    /// The filter's start date.
    created_after: ?i64 = null,

    /// The filter's end date.
    created_before: ?i64 = null,

    /// The name to filter on.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_after = "createdAfter",
        .created_before = "createdBefore",
        .name = "name",
    };
};
