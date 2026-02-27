const CastColumnTypeOperation = @import("cast_column_type_operation.zig").CastColumnTypeOperation;
const TransformOperationSource = @import("transform_operation_source.zig").TransformOperationSource;

/// A transform operation that changes the data types of one or more columns in
/// the dataset.
pub const CastColumnTypesOperation = struct {
    /// Alias for this operation.
    alias: []const u8,

    /// The list of column type casting operations to perform.
    cast_column_type_operations: []const CastColumnTypeOperation,

    /// The source transform operation that provides input data for the type
    /// casting.
    source: TransformOperationSource,

    pub const json_field_names = .{
        .alias = "Alias",
        .cast_column_type_operations = "CastColumnTypeOperations",
        .source = "Source",
    };
};
