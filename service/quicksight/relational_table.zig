const InputColumn = @import("input_column.zig").InputColumn;

/// A physical table type for relational data sources.
pub const RelationalTable = struct {
    /// The catalog associated with a table.
    catalog: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the data source.
    data_source_arn: []const u8,

    /// The column schema of the table.
    input_columns: []const InputColumn,

    /// The name of the relational table.
    name: []const u8,

    /// The schema name. This name applies to certain relational database engines.
    schema: ?[]const u8 = null,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .data_source_arn = "DataSourceArn",
        .input_columns = "InputColumns",
        .name = "Name",
        .schema = "Schema",
    };
};
