const AutoDataQuality = @import("auto_data_quality.zig").AutoDataQuality;
const CatalogSchemaChangePolicy = @import("catalog_schema_change_policy.zig").CatalogSchemaChangePolicy;

/// Specifies a data target that writes to Amazon S3 using the Glue Data
/// Catalog.
pub const S3CatalogTarget = struct {
    /// Specifies whether to automatically enable data quality evaluation for the S3
    /// catalog target.
    /// When set to `true`, data quality checks are performed automatically during
    /// the write operation.
    auto_data_quality: ?AutoDataQuality = null,

    /// The name of the database to write to.
    database: []const u8,

    /// The nodes that are inputs to the data target.
    inputs: []const []const u8,

    /// The name of the data target.
    name: []const u8,

    /// Specifies native partitioning using a sequence of keys.
    partition_keys: ?[]const []const []const u8 = null,

    /// A policy that specifies update behavior for the crawler.
    schema_change_policy: ?CatalogSchemaChangePolicy = null,

    /// The name of the table in the database to write to.
    table: []const u8,

    pub const json_field_names = .{
        .auto_data_quality = "AutoDataQuality",
        .database = "Database",
        .inputs = "Inputs",
        .name = "Name",
        .partition_keys = "PartitionKeys",
        .schema_change_policy = "SchemaChangePolicy",
        .table = "Table",
    };
};
