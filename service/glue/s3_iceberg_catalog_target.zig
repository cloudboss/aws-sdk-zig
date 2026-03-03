const aws = @import("aws");

const AutoDataQuality = @import("auto_data_quality.zig").AutoDataQuality;
const CatalogSchemaChangePolicy = @import("catalog_schema_change_policy.zig").CatalogSchemaChangePolicy;

/// Specifies an Apache Iceberg catalog target that writes data to Amazon S3 and
/// registers the table in the Glue Data Catalog.
pub const S3IcebergCatalogTarget = struct {
    /// Specifies additional connection options for the Iceberg catalog target.
    additional_options: ?[]const aws.map.StringMapEntry = null,

    /// Specifies whether to automatically enable data quality evaluation for the S3
    /// Iceberg catalog target. When set to `true`, data quality checks are
    /// performed automatically during the write operation.
    auto_data_quality: ?AutoDataQuality = null,

    /// The name of the database to write to.
    database: []const u8,

    /// The input connection for the Iceberg catalog target.
    inputs: []const []const u8,

    /// The name of the Iceberg catalog target.
    name: []const u8,

    /// A list of partition keys for the Iceberg table.
    partition_keys: ?[]const []const []const u8 = null,

    /// The policy for handling schema changes in the catalog target.
    schema_change_policy: ?CatalogSchemaChangePolicy = null,

    /// The name of the table to write to in the catalog.
    table: []const u8,

    pub const json_field_names = .{
        .additional_options = "AdditionalOptions",
        .auto_data_quality = "AutoDataQuality",
        .database = "Database",
        .inputs = "Inputs",
        .name = "Name",
        .partition_keys = "PartitionKeys",
        .schema_change_policy = "SchemaChangePolicy",
        .table = "Table",
    };
};
