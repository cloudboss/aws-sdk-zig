const ColumnToUnpivot = @import("column_to_unpivot.zig").ColumnToUnpivot;
const TransformOperationSource = @import("transform_operation_source.zig").TransformOperationSource;

/// A transform operation that converts columns into rows, normalizing the data
/// structure.
pub const UnpivotOperation = struct {
    /// Alias for this operation.
    alias: []const u8,

    /// The list of columns to unpivot from the source data.
    columns_to_unpivot: []const ColumnToUnpivot,

    /// The source transform operation that provides input data for unpivoting.
    source: TransformOperationSource,

    /// A unique identifier for the new column that will contain the unpivoted
    /// column names.
    unpivoted_label_column_id: []const u8,

    /// The name for the new column that will contain the unpivoted column names.
    unpivoted_label_column_name: []const u8,

    /// A unique identifier for the new column that will contain the unpivoted
    /// values.
    unpivoted_value_column_id: []const u8,

    /// The name for the new column that will contain the unpivoted values.
    unpivoted_value_column_name: []const u8,

    pub const json_field_names = .{
        .alias = "Alias",
        .columns_to_unpivot = "ColumnsToUnpivot",
        .source = "Source",
        .unpivoted_label_column_id = "UnpivotedLabelColumnId",
        .unpivoted_label_column_name = "UnpivotedLabelColumnName",
        .unpivoted_value_column_id = "UnpivotedValueColumnId",
        .unpivoted_value_column_name = "UnpivotedValueColumnName",
    };
};
