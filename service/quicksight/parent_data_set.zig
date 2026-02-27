const InputColumn = @import("input_column.zig").InputColumn;

/// References a parent dataset that serves as a data source, including its
/// columns and metadata.
pub const ParentDataSet = struct {
    /// The Amazon Resource Name (ARN) of the parent dataset.
    data_set_arn: []const u8,

    /// The list of input columns available from the parent dataset.
    input_columns: []const InputColumn,

    pub const json_field_names = .{
        .data_set_arn = "DataSetArn",
        .input_columns = "InputColumns",
    };
};
