const TableOptimizer = @import("table_optimizer.zig").TableOptimizer;

/// Contains details for one of the table optimizers returned by the
/// `BatchGetTableOptimizer` operation.
pub const BatchTableOptimizer = struct {
    /// The Catalog ID of the table.
    catalog_id: ?[]const u8 = null,

    /// The name of the database in the catalog in which the table resides.
    database_name: ?[]const u8 = null,

    /// The name of the table.
    table_name: ?[]const u8 = null,

    /// A `TableOptimizer` object that contains details on the configuration and
    /// last run of a table optimizer.
    table_optimizer: ?TableOptimizer = null,

    pub const json_field_names = .{
        .catalog_id = "catalogId",
        .database_name = "databaseName",
        .table_name = "tableName",
        .table_optimizer = "tableOptimizer",
    };
};
