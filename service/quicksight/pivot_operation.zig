const PivotConfiguration = @import("pivot_configuration.zig").PivotConfiguration;
const TransformOperationSource = @import("transform_operation_source.zig").TransformOperationSource;
const ValueColumnConfiguration = @import("value_column_configuration.zig").ValueColumnConfiguration;

/// A transform operation that pivots data by converting row values into
/// columns.
pub const PivotOperation = struct {
    /// Alias for this operation.
    alias: []const u8,

    /// The list of column names to group by when performing the pivot operation.
    group_by_column_names: ?[]const []const u8 = null,

    /// Configuration that specifies which labels to pivot and how to structure the
    /// resulting columns.
    pivot_configuration: PivotConfiguration,

    /// The source transform operation that provides input data for pivoting.
    source: TransformOperationSource,

    /// Configuration for how to aggregate values when multiple rows map to the same
    /// pivoted column.
    value_column_configuration: ValueColumnConfiguration,

    pub const json_field_names = .{
        .alias = "Alias",
        .group_by_column_names = "GroupByColumnNames",
        .pivot_configuration = "PivotConfiguration",
        .source = "Source",
        .value_column_configuration = "ValueColumnConfiguration",
    };
};
