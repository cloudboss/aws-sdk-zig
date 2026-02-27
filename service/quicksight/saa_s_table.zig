const InputColumn = @import("input_column.zig").InputColumn;
const TablePathElement = @import("table_path_element.zig").TablePathElement;

/// A table from a Software-as-a-Service (SaaS) data source, including
/// connection details and column definitions.
pub const SaaSTable = struct {
    /// The Amazon Resource Name (ARN) of the SaaS data source.
    data_source_arn: []const u8,

    /// The list of input columns available from the SaaS table.
    input_columns: []const InputColumn,

    /// The hierarchical path to the table within the SaaS data source.
    table_path: []const TablePathElement,

    pub const json_field_names = .{
        .data_source_arn = "DataSourceArn",
        .input_columns = "InputColumns",
        .table_path = "TablePath",
    };
};
