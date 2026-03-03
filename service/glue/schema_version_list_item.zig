const SchemaVersionStatus = @import("schema_version_status.zig").SchemaVersionStatus;

/// An object containing the details about a schema version.
pub const SchemaVersionListItem = struct {
    /// The date and time the schema version was created.
    created_time: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the schema.
    schema_arn: ?[]const u8 = null,

    /// The unique identifier of the schema version.
    schema_version_id: ?[]const u8 = null,

    /// The status of the schema version.
    status: ?SchemaVersionStatus = null,

    /// The version number of the schema.
    version_number: ?i64 = null,

    pub const json_field_names = .{
        .created_time = "CreatedTime",
        .schema_arn = "SchemaArn",
        .schema_version_id = "SchemaVersionId",
        .status = "Status",
        .version_number = "VersionNumber",
    };
};
