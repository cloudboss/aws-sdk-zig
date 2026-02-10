const TargetGrant = @import("target_grant.zig").TargetGrant;
const TargetObjectKeyFormat = @import("target_object_key_format.zig").TargetObjectKeyFormat;

/// Describes where logs are stored and the prefix that Amazon S3 assigns to all
/// log object keys for a
/// bucket. For more information, see [PUT Bucket
/// logging](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTlogging.html) in the
/// *Amazon S3 API Reference*.
pub const LoggingEnabled = struct {
    /// Specifies the bucket where you want Amazon S3 to store server access logs.
    /// You can have your logs
    /// delivered to any bucket that you own, including the same bucket that is
    /// being logged. You can also
    /// configure multiple buckets to deliver their logs to the same target bucket.
    /// In this case, you should
    /// choose a different `TargetPrefix` for each source bucket so that the
    /// delivered log files can
    /// be distinguished by key.
    target_bucket: []const u8,

    /// Container for granting information.
    ///
    /// Buckets that use the bucket owner enforced setting for Object Ownership
    /// don't support target grants.
    /// For more information, see [Permissions for server access log
    /// delivery](https://docs.aws.amazon.com/AmazonS3/latest/userguide/enable-server-access-logging.html#grant-log-delivery-permissions-general) in the
    /// *Amazon S3 User Guide*.
    target_grants: ?[]const TargetGrant,

    /// Amazon S3 key format for log objects.
    target_object_key_format: ?TargetObjectKeyFormat,

    /// A prefix for all log object keys. If you store log files from multiple
    /// Amazon S3 buckets in a single
    /// bucket, you can use a prefix to distinguish which log files came from which
    /// bucket.
    target_prefix: []const u8,
};
