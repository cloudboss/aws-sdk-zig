/// Connector SSM command config.
pub const ConnectorSsmCommandConfig = struct {
    /// Connector SSM command config CloudWatch log group name.
    cloud_watch_log_group_name: ?[]const u8,

    /// Connector SSM command config CloudWatch output enabled.
    cloud_watch_output_enabled: bool,

    /// Connector SSM command config output S3 bucket name.
    output_s3_bucket_name: ?[]const u8,

    /// Connector SSM command config S3 output enabled.
    s_3_output_enabled: bool,

    pub const json_field_names = .{
        .cloud_watch_log_group_name = "cloudWatchLogGroupName",
        .cloud_watch_output_enabled = "cloudWatchOutputEnabled",
        .output_s3_bucket_name = "outputS3BucketName",
        .s_3_output_enabled = "s3OutputEnabled",
    };
};
