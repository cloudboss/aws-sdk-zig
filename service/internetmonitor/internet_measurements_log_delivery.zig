const S3Config = @import("s3_config.zig").S3Config;

/// Publish internet measurements to an Amazon S3 bucket in addition to
/// CloudWatch Logs.
pub const InternetMeasurementsLogDelivery = struct {
    /// The configuration information for publishing Internet Monitor internet
    /// measurements to Amazon S3. The configuration includes the bucket name and
    /// (optionally) prefix
    /// for the S3 bucket to store the measurements, and the delivery status. The
    /// delivery status is `ENABLED` or `DISABLED`, depending on
    /// whether you choose to deliver internet measurements to S3 logs.
    s3_config: ?S3Config,

    pub const json_field_names = .{
        .s3_config = "S3Config",
    };
};
