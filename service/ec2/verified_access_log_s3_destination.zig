const VerifiedAccessLogDeliveryStatus = @import("verified_access_log_delivery_status.zig").VerifiedAccessLogDeliveryStatus;

/// Options for Amazon S3 as a logging destination.
pub const VerifiedAccessLogS3Destination = struct {
    /// The bucket name.
    bucket_name: ?[]const u8 = null,

    /// The Amazon Web Services account number that owns the bucket.
    bucket_owner: ?[]const u8 = null,

    /// The delivery status.
    delivery_status: ?VerifiedAccessLogDeliveryStatus = null,

    /// Indicates whether logging is enabled.
    enabled: ?bool = null,

    /// The bucket prefix.
    prefix: ?[]const u8 = null,
};
