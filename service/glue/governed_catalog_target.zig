const CatalogSchemaChangePolicy = @import("catalog_schema_change_policy.zig").CatalogSchemaChangePolicy;

/// Specifies a data target that writes to Amazon S3 using the Glue Data
/// Catalog.
pub const GovernedCatalogTarget = struct {
    /// The name of the database to write to.
    database: []const u8,

    /// The nodes that are inputs to the data target.
    inputs: []const []const u8,

    /// The name of the data target.
    name: []const u8,

    /// Specifies native partitioning using a sequence of keys.
    partition_keys: ?[]const []const []const u8,

    /// A policy that specifies update behavior for the governed catalog.
    schema_change_policy: ?CatalogSchemaChangePolicy,

    /// The name of the table in the database to write to.
    table: []const u8,

    pub const json_field_names = .{
        .database = "Database",
        .inputs = "Inputs",
        .name = "Name",
        .partition_keys = "PartitionKeys",
        .schema_change_policy = "SchemaChangePolicy",
        .table = "Table",
    };
};
