const BillingAdjustmentErrorCode = @import("billing_adjustment_error_code.zig").BillingAdjustmentErrorCode;

/// An error for a billing adjustment request entry that failed validation.
pub const BatchCreateBillingAdjustmentError = struct {
    /// The client token of the request entry that failed.
    client_token: []const u8,

    /// The error code indicating the reason for failure.
    code: BillingAdjustmentErrorCode,

    /// A human-readable message describing the error.
    message: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .code = "code",
        .message = "message",
    };
};
