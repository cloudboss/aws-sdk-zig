const SchemaStatus = @import("schema_status.zig").SchemaStatus;

/// An object that contains minimal details for a schema.
pub const SchemaListItem = struct {
    /// The date and time that a schema was created.
    created_time: ?[]const u8,

    /// A description for the schema.
    description: ?[]const u8,

    /// the name of the registry where the schema resides.
    registry_name: ?[]const u8,

    /// The Amazon Resource Name (ARN) for the schema.
    schema_arn: ?[]const u8,

    /// The name of the schema.
    schema_name: ?[]const u8,

    /// The status of the schema.
    schema_status: ?SchemaStatus,

    /// The date and time that a schema was updated.
    updated_time: ?[]const u8,

    pub const json_field_names = .{
        .created_time = "CreatedTime",
        .description = "Description",
        .registry_name = "RegistryName",
        .schema_arn = "SchemaArn",
        .schema_name = "SchemaName",
        .schema_status = "SchemaStatus",
        .updated_time = "UpdatedTime",
    };
};
