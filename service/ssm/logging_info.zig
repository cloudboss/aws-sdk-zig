/// Information about an Amazon Simple Storage Service (Amazon S3) bucket to
/// write managed
/// node-level logs to.
///
/// `LoggingInfo` has been deprecated. To specify an Amazon Simple Storage
/// Service (Amazon S3) bucket to contain logs, instead use the
/// `OutputS3BucketName` and `OutputS3KeyPrefix` options in the
/// `TaskInvocationParameters` structure.
/// For information about how Amazon Web Services Systems Manager handles these
/// options for the supported maintenance
/// window task types, see MaintenanceWindowTaskInvocationParameters.
pub const LoggingInfo = struct {
    /// The name of an S3 bucket where execution logs are stored.
    s3_bucket_name: []const u8,

    /// (Optional) The S3 bucket subfolder.
    s3_key_prefix: ?[]const u8,

    /// The Amazon Web Services Region where the S3 bucket is located.
    s3_region: []const u8,

    pub const json_field_names = .{
        .s3_bucket_name = "S3BucketName",
        .s3_key_prefix = "S3KeyPrefix",
        .s3_region = "S3Region",
    };
};
