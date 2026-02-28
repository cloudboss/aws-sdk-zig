const Type = @import("type.zig").Type;

pub const SchemaVersionSummary = struct {
    /// The ARN of the schema version.
    schema_arn: ?[]const u8,

    /// The name of the schema.
    schema_name: ?[]const u8,

    /// The version number of the schema.
    schema_version: ?[]const u8,

    /// The type of schema.
    @"type": ?Type,

    pub const json_field_names = .{
        .schema_arn = "SchemaArn",
        .schema_name = "SchemaName",
        .schema_version = "SchemaVersion",
        .@"type" = "Type",
    };
};
