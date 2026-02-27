const OperationResultFilterName = @import("operation_result_filter_name.zig").OperationResultFilterName;

/// The status that operation results are filtered by.
pub const OperationResultFilter = struct {
    /// The type of filter to apply.
    name: ?OperationResultFilterName,

    /// The value to filter by.
    values: ?[]const u8,
};
