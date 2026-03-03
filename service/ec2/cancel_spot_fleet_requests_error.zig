const CancelBatchErrorCode = @import("cancel_batch_error_code.zig").CancelBatchErrorCode;

/// Describes a Spot Fleet error.
pub const CancelSpotFleetRequestsError = struct {
    /// The error code.
    code: ?CancelBatchErrorCode = null,

    /// The description for the error code.
    message: ?[]const u8 = null,
};
