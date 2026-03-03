const OperationType = @import("operation_type.zig").OperationType;

/// Contains information about a CloudFormation operation.
pub const OperationEntry = struct {
    /// The unique identifier for the operation.
    operation_id: ?[]const u8 = null,

    /// The type of operation.
    operation_type: ?OperationType = null,
};
