const GlueSchema = @import("glue_schema.zig").GlueSchema;

/// Specifies a data store in the Glue Data Catalog.
pub const CatalogSource = struct {
    /// The name of the database to read from.
    database: []const u8,

    /// The name of the data store.
    name: []const u8,

    /// Specifies the data schema for the catalog source.
    output_schemas: ?[]const GlueSchema = null,

    /// Partitions satisfying this predicate are deleted. Files within the retention
    /// period in these partitions are not deleted.
    partition_predicate: ?[]const u8 = null,

    /// The name of the table in the database to read from.
    table: []const u8,

    pub const json_field_names = .{
        .database = "Database",
        .name = "Name",
        .output_schemas = "OutputSchemas",
        .partition_predicate = "PartitionPredicate",
        .table = "Table",
    };
};
