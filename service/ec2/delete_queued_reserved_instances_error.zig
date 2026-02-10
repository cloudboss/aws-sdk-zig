const DeleteQueuedReservedInstancesErrorCode = @import("delete_queued_reserved_instances_error_code.zig").DeleteQueuedReservedInstancesErrorCode;

/// Describes the error for a Reserved Instance whose queued purchase could not
/// be
/// deleted.
pub const DeleteQueuedReservedInstancesError = struct {
    /// The error code.
    code: ?DeleteQueuedReservedInstancesErrorCode,

    /// The error message.
    message: ?[]const u8,
};
