/// Information about a source repository returned in a list of source
/// repositories.
pub const ListSourceRepositoriesItem = struct {
    /// The time the source repository was created, in coordinated universal time
    /// (UTC) timestamp format as specified in [RFC
    /// 3339](https://www.rfc-editor.org/rfc/rfc3339#section-5.6).
    created_time: i64,

    /// The description of the repository, if any.
    description: ?[]const u8,

    /// The system-generated unique ID of the source repository.
    id: []const u8,

    /// The time the source repository was last updated, in coordinated universal
    /// time (UTC) timestamp format as specified in [RFC
    /// 3339](https://www.rfc-editor.org/rfc/rfc3339#section-5.6).
    last_updated_time: i64,

    /// The name of the source repository.
    name: []const u8,

    pub const json_field_names = .{
        .created_time = "createdTime",
        .description = "description",
        .id = "id",
        .last_updated_time = "lastUpdatedTime",
        .name = "name",
    };
};
