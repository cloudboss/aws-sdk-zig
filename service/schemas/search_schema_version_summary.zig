const Type = @import("type.zig").Type;

pub const SearchSchemaVersionSummary = struct {
    /// The date the schema version was created.
    created_date: ?i64 = null,

    /// The version number of the schema
    schema_version: ?[]const u8 = null,

    /// The type of schema.
    @"type": ?Type = null,

    pub const json_field_names = .{
        .created_date = "CreatedDate",
        .schema_version = "SchemaVersion",
        .@"type" = "Type",
    };
};
