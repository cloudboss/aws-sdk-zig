const FilterOperation = @import("filter_operation.zig").FilterOperation;
const TransformOperationSource = @import("transform_operation_source.zig").TransformOperationSource;

/// A transform operation that applies one or more filter conditions.
pub const FiltersOperation = struct {
    /// Alias for this operation.
    alias: []const u8,

    /// The list of filter operations to apply.
    filter_operations: []const FilterOperation,

    /// The source transform operation that provides input data for filtering.
    source: TransformOperationSource,

    pub const json_field_names = .{
        .alias = "Alias",
        .filter_operations = "FilterOperations",
        .source = "Source",
    };
};
