/// Attributes of an accelerator.
pub const AcceleratorAttributes = struct {
    /// Indicates whether flow logs are enabled. The default value is false. If the
    /// value is true,
    /// `FlowLogsS3Bucket` and `FlowLogsS3Prefix` must be specified.
    ///
    /// For more information, see [Flow
    /// logs](https://docs.aws.amazon.com/global-accelerator/latest/dg/monitoring-global-accelerator.flow-logs.html) in
    /// the *Global Accelerator Developer Guide*.
    flow_logs_enabled: ?bool,

    /// The name of the Amazon S3 bucket for the flow logs. Attribute is required if
    /// `FlowLogsEnabled` is
    /// `true`. The bucket must exist and have a bucket policy that grants Global
    /// Accelerator permission to write to the
    /// bucket.
    flow_logs_s3_bucket: ?[]const u8,

    /// The prefix for the location in the Amazon S3 bucket for the flow logs.
    /// Attribute is required if
    /// `FlowLogsEnabled` is `true`.
    ///
    /// If you specify slash (/) for the S3 bucket prefix, the log file bucket
    /// folder structure will include a double slash (//), like the following:
    ///
    /// s3-bucket_name//AWSLogs/aws_account_id
    flow_logs_s3_prefix: ?[]const u8,

    pub const json_field_names = .{
        .flow_logs_enabled = "FlowLogsEnabled",
        .flow_logs_s3_bucket = "FlowLogsS3Bucket",
        .flow_logs_s3_prefix = "FlowLogsS3Prefix",
    };
};
