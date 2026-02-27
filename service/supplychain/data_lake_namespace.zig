/// The data lake namespace details.
pub const DataLakeNamespace = struct {
    /// The arn of the namespace.
    arn: []const u8,

    /// The creation time of the namespace.
    created_time: i64,

    /// The description of the namespace.
    description: ?[]const u8,

    /// The Amazon Web Services Supply Chain instance identifier.
    instance_id: []const u8,

    /// The last modified time of the namespace.
    last_modified_time: i64,

    /// The name of the namespace.
    name: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .created_time = "createdTime",
        .description = "description",
        .instance_id = "instanceId",
        .last_modified_time = "lastModifiedTime",
        .name = "name",
    };
};
