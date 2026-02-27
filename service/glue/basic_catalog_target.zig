/// Specifies a target that uses a Glue Data Catalog table.
pub const BasicCatalogTarget = struct {
    /// The database that contains the table you want to use as the target. This
    /// database must already exist in the Data Catalog.
    database: []const u8,

    /// The nodes that are inputs to the data target.
    inputs: []const []const u8,

    /// The name of your data target.
    name: []const u8,

    /// The partition keys used to distribute data across multiple partitions or
    /// shards based on a specific key or set of key.
    partition_keys: ?[]const []const []const u8,

    /// The table that defines the schema of your output data. This table must
    /// already exist in the Data Catalog.
    table: []const u8,

    pub const json_field_names = .{
        .database = "Database",
        .inputs = "Inputs",
        .name = "Name",
        .partition_keys = "PartitionKeys",
        .table = "Table",
    };
};
