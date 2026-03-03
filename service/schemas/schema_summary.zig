const aws = @import("aws");

/// A summary of schema details.
pub const SchemaSummary = struct {
    /// The date and time that schema was modified.
    last_modified: ?i64 = null,

    /// The ARN of the schema.
    schema_arn: ?[]const u8 = null,

    /// The name of the schema.
    schema_name: ?[]const u8 = null,

    /// Tags associated with the schema.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The number of versions available for the schema.
    version_count: ?i64 = null,

    pub const json_field_names = .{
        .last_modified = "LastModified",
        .schema_arn = "SchemaArn",
        .schema_name = "SchemaName",
        .tags = "Tags",
        .version_count = "VersionCount",
    };
};
