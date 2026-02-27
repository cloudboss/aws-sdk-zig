/// Provides the name of the schema and table to be reloaded.
pub const TableToReload = struct {
    /// The schema name of the table to be reloaded.
    schema_name: []const u8,

    /// The table name of the table to be reloaded.
    table_name: []const u8,

    pub const json_field_names = .{
        .schema_name = "SchemaName",
        .table_name = "TableName",
    };
};
