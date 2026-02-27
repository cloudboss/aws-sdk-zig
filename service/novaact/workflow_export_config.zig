/// Configuration settings for exporting workflow execution data and logs to
/// Amazon Simple Storage Service (Amazon S3).
pub const WorkflowExportConfig = struct {
    /// The name of your Amazon S3 bucket, that Nova Act uses to export your
    /// workflow data. Note that the IAM role used to access Nova Act must also have
    /// write permissions to this bucket.
    s_3_bucket_name: []const u8,

    /// An optional prefix for Amazon S3 object keys to organize exported data.
    s_3_key_prefix: ?[]const u8,

    pub const json_field_names = .{
        .s_3_bucket_name = "s3BucketName",
        .s_3_key_prefix = "s3KeyPrefix",
    };
};
