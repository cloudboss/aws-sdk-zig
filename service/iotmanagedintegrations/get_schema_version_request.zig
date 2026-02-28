const SchemaVersionFormat = @import("schema_version_format.zig").SchemaVersionFormat;
const SchemaVersionType = @import("schema_version_type.zig").SchemaVersionType;

pub const GetSchemaVersionRequest = struct {
    /// The format of the schema version.
    format: ?SchemaVersionFormat,

    /// Schema id with a version specified. If the version is missing, it defaults
    /// to latest version.
    schema_versioned_id: []const u8,

    /// The type of schema version.
    @"type": SchemaVersionType,

    pub const json_field_names = .{
        .format = "Format",
        .schema_versioned_id = "SchemaVersionedId",
        .@"type" = "Type",
    };
};
