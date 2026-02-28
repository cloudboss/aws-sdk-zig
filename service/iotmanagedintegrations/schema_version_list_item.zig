const SchemaVersionType = @import("schema_version_type.zig").SchemaVersionType;
const SchemaVersionVisibility = @import("schema_version_visibility.zig").SchemaVersionVisibility;

/// List item describing a schema version.
pub const SchemaVersionListItem = struct {
    /// A description of the schema version.
    description: ?[]const u8,

    /// The name of the schema version.
    namespace: ?[]const u8,

    /// The identifier of the schema version.
    schema_id: ?[]const u8,

    /// The schema version. If this is left blank, it defaults to the latest
    /// version.
    semantic_version: ?[]const u8,

    /// The type of schema version.
    @"type": ?SchemaVersionType,

    /// The visibility of the schema version.
    visibility: ?SchemaVersionVisibility,

    pub const json_field_names = .{
        .description = "Description",
        .namespace = "Namespace",
        .schema_id = "SchemaId",
        .semantic_version = "SemanticVersion",
        .@"type" = "Type",
        .visibility = "Visibility",
    };
};
