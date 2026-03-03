const VerifiedAccessLogDeliveryStatus = @import("verified_access_log_delivery_status.zig").VerifiedAccessLogDeliveryStatus;

/// Options for Kinesis as a logging destination.
pub const VerifiedAccessLogKinesisDataFirehoseDestination = struct {
    /// The delivery status.
    delivery_status: ?VerifiedAccessLogDeliveryStatus = null,

    /// The ID of the delivery stream.
    delivery_stream: ?[]const u8 = null,

    /// Indicates whether logging is enabled.
    enabled: ?bool = null,
};
