const SearchSchemaVersionSummary = @import("search_schema_version_summary.zig").SearchSchemaVersionSummary;

pub const SearchSchemaSummary = struct {
    /// The name of the registry.
    registry_name: ?[]const u8 = null,

    /// The ARN of the schema.
    schema_arn: ?[]const u8 = null,

    /// The name of the schema.
    schema_name: ?[]const u8 = null,

    /// An array of schema version summaries.
    schema_versions: ?[]const SearchSchemaVersionSummary = null,

    pub const json_field_names = .{
        .registry_name = "RegistryName",
        .schema_arn = "SchemaArn",
        .schema_name = "SchemaName",
        .schema_versions = "SchemaVersions",
    };
};
