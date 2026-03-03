const TableOptimizerType = @import("table_optimizer_type.zig").TableOptimizerType;

/// Represents a table optimizer to retrieve in the `BatchGetTableOptimizer`
/// operation.
pub const BatchGetTableOptimizerEntry = struct {
    /// The Catalog ID of the table.
    catalog_id: ?[]const u8 = null,

    /// The name of the database in the catalog in which the table resides.
    database_name: ?[]const u8 = null,

    /// The name of the table.
    table_name: ?[]const u8 = null,

    /// The type of table optimizer.
    @"type": ?TableOptimizerType = null,

    pub const json_field_names = .{
        .catalog_id = "catalogId",
        .database_name = "databaseName",
        .table_name = "tableName",
        .@"type" = "type",
    };
};
