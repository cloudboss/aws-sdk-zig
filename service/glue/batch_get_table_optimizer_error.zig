const ErrorDetail = @import("error_detail.zig").ErrorDetail;
const TableOptimizerType = @import("table_optimizer_type.zig").TableOptimizerType;

/// Contains details on one of the errors in the error list returned by the
/// `BatchGetTableOptimizer` operation.
pub const BatchGetTableOptimizerError = struct {
    /// The Catalog ID of the table.
    catalog_id: ?[]const u8,

    /// The name of the database in the catalog in which the table resides.
    database_name: ?[]const u8,

    /// An `ErrorDetail` object containing code and message details about the error.
    @"error": ?ErrorDetail,

    /// The name of the table.
    table_name: ?[]const u8,

    /// The type of table optimizer.
    type: ?TableOptimizerType,

    pub const json_field_names = .{
        .catalog_id = "catalogId",
        .database_name = "databaseName",
        .@"error" = "error",
        .table_name = "tableName",
        .type = "type",
    };
};
