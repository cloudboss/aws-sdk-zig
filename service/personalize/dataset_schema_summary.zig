const Domain = @import("domain.zig").Domain;

/// Provides a summary of the properties of a dataset schema. For a complete
/// listing, call the
/// [DescribeSchema](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeSchema.html) API.
pub const DatasetSchemaSummary = struct {
    /// The date and time (in Unix time) that the schema was created.
    creation_date_time: ?i64,

    /// The domain of a schema that you created for a dataset in a Domain dataset
    /// group.
    domain: ?Domain,

    /// The date and time (in Unix time) that the schema was last updated.
    last_updated_date_time: ?i64,

    /// The name of the schema.
    name: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the schema.
    schema_arn: ?[]const u8,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .domain = "domain",
        .last_updated_date_time = "lastUpdatedDateTime",
        .name = "name",
        .schema_arn = "schemaArn",
    };
};
