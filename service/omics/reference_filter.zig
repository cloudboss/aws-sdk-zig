/// A filter for references.
pub const ReferenceFilter = struct {
    /// The filter's start date.
    created_after: ?i64,

    /// The filter's end date.
    created_before: ?i64,

    /// An MD5 checksum to filter on.
    md_5: ?[]const u8,

    /// A name to filter on.
    name: ?[]const u8,

    pub const json_field_names = .{
        .created_after = "createdAfter",
        .created_before = "createdBefore",
        .md_5 = "md5",
        .name = "name",
    };
};
