/// A snapshot of the documentation of an API.
pub const DocumentationVersion = struct {
    /// The date when the API documentation snapshot is created.
    created_date: ?i64,

    /// The description of the API documentation snapshot.
    description: ?[]const u8,

    /// The version identifier of the API documentation snapshot.
    version: ?[]const u8,

    pub const json_field_names = .{
        .created_date = "createdDate",
        .description = "description",
        .version = "version",
    };
};
