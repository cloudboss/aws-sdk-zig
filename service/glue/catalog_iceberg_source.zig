const aws = @import("aws");

const GlueSchema = @import("glue_schema.zig").GlueSchema;

/// Specifies an Apache Iceberg data source that is registered in the Glue Data
/// Catalog.
pub const CatalogIcebergSource = struct {
    /// Specifies additional connection options for the Iceberg data source.
    additional_iceberg_options: ?[]const aws.map.StringMapEntry,

    /// The name of the database to read from.
    database: []const u8,

    /// The name of the Iceberg data source.
    name: []const u8,

    /// Specifies the data schema for the Iceberg source.
    output_schemas: ?[]const GlueSchema,

    /// The name of the table in the database to read from.
    table: []const u8,

    pub const json_field_names = .{
        .additional_iceberg_options = "AdditionalIcebergOptions",
        .database = "Database",
        .name = "Name",
        .output_schemas = "OutputSchemas",
        .table = "Table",
    };
};
