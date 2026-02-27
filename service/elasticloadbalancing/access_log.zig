/// Information about the `AccessLog` attribute.
pub const AccessLog = struct {
    /// The interval for publishing the access logs. You can specify an interval of
    /// either 5 minutes or 60 minutes.
    ///
    /// Default: 60 minutes
    emit_interval: ?i32,

    /// Specifies whether access logs are enabled for the load balancer.
    enabled: bool = false,

    /// The name of the Amazon S3 bucket where the access logs are stored.
    s3_bucket_name: ?[]const u8,

    /// The logical hierarchy you created for your Amazon S3 bucket, for example
    /// `my-bucket-prefix/prod`.
    /// If the prefix is not provided, the log is placed at the root level of the
    /// bucket.
    s3_bucket_prefix: ?[]const u8,
};
