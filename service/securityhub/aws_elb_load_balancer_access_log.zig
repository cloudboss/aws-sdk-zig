/// Contains information about the access log configuration for the load
/// balancer.
pub const AwsElbLoadBalancerAccessLog = struct {
    /// The interval in minutes for publishing the access logs.
    ///
    /// You can publish access logs either every 5 minutes or every 60 minutes.
    emit_interval: ?i32,

    /// Indicates whether access logs are enabled for the load balancer.
    enabled: ?bool,

    /// The name of the S3 bucket where the access logs are stored.
    s3_bucket_name: ?[]const u8,

    /// The logical hierarchy that was created for the S3 bucket.
    ///
    /// If a prefix is not provided, the log is placed at the root level of the
    /// bucket.
    s3_bucket_prefix: ?[]const u8,

    pub const json_field_names = .{
        .emit_interval = "EmitInterval",
        .enabled = "Enabled",
        .s3_bucket_name = "S3BucketName",
        .s3_bucket_prefix = "S3BucketPrefix",
    };
};
