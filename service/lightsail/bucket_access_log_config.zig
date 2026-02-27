/// Describes the access log configuration for a bucket in the Amazon Lightsail
/// object storage
/// service.
///
/// For more information about bucket access logs, see [Logging bucket requests
/// using access logging in Amazon
/// Lightsail](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-bucket-access-logs) in the
/// *Amazon Lightsail Developer Guide*.
pub const BucketAccessLogConfig = struct {
    /// The name of the bucket where the access logs are saved. The destination can
    /// be a
    /// Lightsail bucket in the same account, and in the same Amazon Web Services
    /// Region as the
    /// source bucket.
    ///
    /// This parameter is required when enabling the access log for a bucket, and
    /// should be
    /// omitted when disabling the access log.
    destination: ?[]const u8,

    /// A Boolean value that indicates whether bucket access logging is enabled for
    /// the
    /// bucket.
    enabled: bool,

    /// The optional object prefix for the bucket access log.
    ///
    /// The prefix is an optional addition to the object key that organizes your
    /// access log files
    /// in the destination bucket. For example, if you specify a `logs/` prefix,
    /// then each
    /// log object will begin with the `logs/` prefix in its key (for example,
    /// `logs/2021-11-01-21-32-16-E568B2907131C0C0`).
    ///
    /// This parameter can be optionally specified when enabling the access log for
    /// a bucket,
    /// and should be omitted when disabling the access log.
    prefix: ?[]const u8,

    pub const json_field_names = .{
        .destination = "destination",
        .enabled = "enabled",
        .prefix = "prefix",
    };
};
