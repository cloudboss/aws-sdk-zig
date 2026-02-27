const aws = @import("aws");

const GlueSchema = @import("glue_schema.zig").GlueSchema;

/// Specifies a Hudi data source that is registered in the Glue Data Catalog.
pub const CatalogHudiSource = struct {
    /// Specifies additional connection options.
    additional_hudi_options: ?[]const aws.map.StringMapEntry,

    /// The name of the database to read from.
    database: []const u8,

    /// The name of the Hudi data source.
    name: []const u8,

    /// Specifies the data schema for the Hudi source.
    output_schemas: ?[]const GlueSchema,

    /// The name of the table in the database to read from.
    table: []const u8,

    pub const json_field_names = .{
        .additional_hudi_options = "AdditionalHudiOptions",
        .database = "Database",
        .name = "Name",
        .output_schemas = "OutputSchemas",
        .table = "Table",
    };
};
