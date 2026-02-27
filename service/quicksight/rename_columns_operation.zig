const RenameColumnOperation = @import("rename_column_operation.zig").RenameColumnOperation;
const TransformOperationSource = @import("transform_operation_source.zig").TransformOperationSource;

/// A transform operation that renames one or more columns in the dataset.
pub const RenameColumnsOperation = struct {
    /// Alias for this operation.
    alias: []const u8,

    /// The list of column rename operations to perform, specifying old and new
    /// column names.
    rename_column_operations: []const RenameColumnOperation,

    /// The source transform operation that provides input data for column renaming.
    source: TransformOperationSource,

    pub const json_field_names = .{
        .alias = "Alias",
        .rename_column_operations = "RenameColumnOperations",
        .source = "Source",
    };
};
