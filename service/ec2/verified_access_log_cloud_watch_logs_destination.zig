const VerifiedAccessLogDeliveryStatus = @import("verified_access_log_delivery_status.zig").VerifiedAccessLogDeliveryStatus;

/// Options for CloudWatch Logs as a logging destination.
pub const VerifiedAccessLogCloudWatchLogsDestination = struct {
    /// The delivery status for access logs.
    delivery_status: ?VerifiedAccessLogDeliveryStatus = null,

    /// Indicates whether logging is enabled.
    enabled: ?bool = null,

    /// The ID of the CloudWatch Logs log group.
    log_group: ?[]const u8 = null,
};
