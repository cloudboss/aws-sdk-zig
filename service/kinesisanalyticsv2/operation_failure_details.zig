const ErrorInfo = @import("error_info.zig").ErrorInfo;

/// Provides a description of the operation failure.
pub const OperationFailureDetails = struct {
    error_info: ?ErrorInfo = null,

    /// The rollback operation ID of the system-rollback operation that executed due
    /// to failure in the current operation.
    rollback_operation_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_info = "ErrorInfo",
        .rollback_operation_id = "RollbackOperationId",
    };
};
