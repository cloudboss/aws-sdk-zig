const aws = @import("aws");

const AutoDataQuality = @import("auto_data_quality.zig").AutoDataQuality;
const GlueSchema = @import("glue_schema.zig").GlueSchema;
const CatalogSchemaChangePolicy = @import("catalog_schema_change_policy.zig").CatalogSchemaChangePolicy;

/// Specifies a target that writes to a Delta Lake data source in the Glue Data
/// Catalog.
pub const S3DeltaCatalogTarget = struct {
    /// Specifies additional connection options for the connector.
    additional_options: ?[]const aws.map.StringMapEntry,

    /// Specifies whether to automatically enable data quality evaluation for the S3
    /// Delta catalog target. When set to `true`,
    /// data quality checks are performed automatically during the write operation.
    auto_data_quality: ?AutoDataQuality,

    /// The name of the database to write to.
    database: []const u8,

    /// The nodes that are inputs to the data target.
    inputs: []const []const u8,

    /// The name of the data target.
    name: []const u8,

    /// Specifies the data schema for the S3 Delta catalog target.
    output_schemas: ?[]const GlueSchema,

    /// Specifies native partitioning using a sequence of keys.
    partition_keys: ?[]const []const []const u8,

    /// A policy that specifies update behavior for the crawler.
    schema_change_policy: ?CatalogSchemaChangePolicy,

    /// The name of the table in the database to write to.
    table: []const u8,

    pub const json_field_names = .{
        .additional_options = "AdditionalOptions",
        .auto_data_quality = "AutoDataQuality",
        .database = "Database",
        .inputs = "Inputs",
        .name = "Name",
        .output_schemas = "OutputSchemas",
        .partition_keys = "PartitionKeys",
        .schema_change_policy = "SchemaChangePolicy",
        .table = "Table",
    };
};
