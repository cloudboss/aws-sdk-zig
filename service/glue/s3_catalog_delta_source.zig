const aws = @import("aws");

const GlueSchema = @import("glue_schema.zig").GlueSchema;

/// Specifies a Delta Lake data source that is registered in the Glue Data
/// Catalog. The data source must be stored in Amazon S3.
pub const S3CatalogDeltaSource = struct {
    /// Specifies additional connection options.
    additional_delta_options: ?[]const aws.map.StringMapEntry = null,

    /// The name of the database to read from.
    database: []const u8,

    /// The name of the Delta Lake data source.
    name: []const u8,

    /// Specifies the data schema for the Delta Lake source.
    output_schemas: ?[]const GlueSchema = null,

    /// The name of the table in the database to read from.
    table: []const u8,

    pub const json_field_names = .{
        .additional_delta_options = "AdditionalDeltaOptions",
        .database = "Database",
        .name = "Name",
        .output_schemas = "OutputSchemas",
        .table = "Table",
    };
};
