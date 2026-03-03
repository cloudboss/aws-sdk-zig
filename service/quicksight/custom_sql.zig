const InputColumn = @import("input_column.zig").InputColumn;

/// A physical table type built from the results of the custom SQL query.
pub const CustomSql = struct {
    /// The column schema from the SQL query result set.
    columns: ?[]const InputColumn = null,

    /// The Amazon Resource Name (ARN) of the data source.
    data_source_arn: []const u8,

    /// A display name for the SQL query result.
    name: []const u8,

    /// The SQL query.
    sql_query: []const u8,

    pub const json_field_names = .{
        .columns = "Columns",
        .data_source_arn = "DataSourceArn",
        .name = "Name",
        .sql_query = "SqlQuery",
    };
};
