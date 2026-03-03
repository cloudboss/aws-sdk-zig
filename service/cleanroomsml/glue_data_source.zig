/// Defines the Glue data source that contains the training data.
pub const GlueDataSource = struct {
    /// The Glue catalog that contains the training data.
    catalog_id: ?[]const u8 = null,

    /// The Glue database that contains the training data.
    database_name: []const u8,

    /// The Glue table that contains the training data.
    table_name: []const u8,

    pub const json_field_names = .{
        .catalog_id = "catalogId",
        .database_name = "databaseName",
        .table_name = "tableName",
    };
};
