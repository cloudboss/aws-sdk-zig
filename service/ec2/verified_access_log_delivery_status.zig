const VerifiedAccessLogDeliveryStatusCode = @import("verified_access_log_delivery_status_code.zig").VerifiedAccessLogDeliveryStatusCode;

/// Describes a log delivery status.
pub const VerifiedAccessLogDeliveryStatus = struct {
    /// The status code.
    code: ?VerifiedAccessLogDeliveryStatusCode,

    /// The status message.
    message: ?[]const u8,
};
