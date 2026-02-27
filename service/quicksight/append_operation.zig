const AppendedColumn = @import("appended_column.zig").AppendedColumn;
const TransformOperationSource = @import("transform_operation_source.zig").TransformOperationSource;

/// A transform operation that combines rows from two data sources by stacking
/// them vertically (union operation).
pub const AppendOperation = struct {
    /// Alias for this operation.
    alias: []const u8,

    /// The list of columns to include in the appended result, mapping columns from
    /// both sources.
    appended_columns: []const AppendedColumn,

    /// The first data source to be included in the append operation.
    first_source: ?TransformOperationSource,

    /// The second data source to be appended to the first source.
    second_source: ?TransformOperationSource,

    pub const json_field_names = .{
        .alias = "Alias",
        .appended_columns = "AppendedColumns",
        .first_source = "FirstSource",
        .second_source = "SecondSource",
    };
};
