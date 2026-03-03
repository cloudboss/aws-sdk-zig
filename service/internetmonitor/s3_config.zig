const LogDeliveryStatus = @import("log_delivery_status.zig").LogDeliveryStatus;

/// The configuration for publishing Amazon CloudWatch Internet Monitor internet
/// measurements to Amazon S3. The configuration includes the bucket name and
/// (optionally) prefix
/// for the S3 bucket to store the measurements, and the delivery status. The
/// delivery status is `ENABLED` or `DISABLED`, depending on
/// whether you choose to deliver internet measurements to S3 logs.
pub const S3Config = struct {
    /// The Amazon S3 bucket name.
    bucket_name: ?[]const u8 = null,

    /// The Amazon S3 bucket prefix.
    bucket_prefix: ?[]const u8 = null,

    /// The status of publishing Internet Monitor internet measurements to an Amazon
    /// S3 bucket.
    log_delivery_status: ?LogDeliveryStatus = null,

    pub const json_field_names = .{
        .bucket_name = "BucketName",
        .bucket_prefix = "BucketPrefix",
        .log_delivery_status = "LogDeliveryStatus",
    };
};
