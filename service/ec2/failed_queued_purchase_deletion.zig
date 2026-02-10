const DeleteQueuedReservedInstancesError = @import("delete_queued_reserved_instances_error.zig").DeleteQueuedReservedInstancesError;

/// Describes a Reserved Instance whose queued purchase was not deleted.
pub const FailedQueuedPurchaseDeletion = struct {
    /// The error.
    @"error": ?DeleteQueuedReservedInstancesError,

    /// The ID of the Reserved Instance.
    reserved_instances_id: ?[]const u8,
};
