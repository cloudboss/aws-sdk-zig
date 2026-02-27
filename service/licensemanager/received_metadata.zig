const AllowedOperation = @import("allowed_operation.zig").AllowedOperation;
const ReceivedStatus = @import("received_status.zig").ReceivedStatus;

/// Metadata associated with received licenses and grants.
pub const ReceivedMetadata = struct {
    /// Allowed operations.
    allowed_operations: ?[]const AllowedOperation,

    /// Received status.
    received_status: ?ReceivedStatus,

    /// Received status reason.
    received_status_reason: ?[]const u8,

    pub const json_field_names = .{
        .allowed_operations = "AllowedOperations",
        .received_status = "ReceivedStatus",
        .received_status_reason = "ReceivedStatusReason",
    };
};
