const Domain = @import("domain.zig").Domain;

/// Describes the schema for a dataset. For more information on schemas, see
/// [CreateSchema](https://docs.aws.amazon.com/personalize/latest/dg/API_CreateSchema.html).
pub const DatasetSchema = struct {
    /// The date and time (in Unix time) that the schema was created.
    creation_date_time: ?i64 = null,

    /// The domain of a schema that you created for a dataset in a Domain dataset
    /// group.
    domain: ?Domain = null,

    /// The date and time (in Unix time) that the schema was last updated.
    last_updated_date_time: ?i64 = null,

    /// The name of the schema.
    name: ?[]const u8 = null,

    /// The schema.
    schema: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the schema.
    schema_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .domain = "domain",
        .last_updated_date_time = "lastUpdatedDateTime",
        .name = "name",
        .schema = "schema",
        .schema_arn = "schemaArn",
    };
};
