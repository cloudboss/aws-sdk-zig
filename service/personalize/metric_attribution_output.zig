const S3DataConfig = @import("s3_data_config.zig").S3DataConfig;

/// The output configuration details for a metric attribution.
pub const MetricAttributionOutput = struct {
    /// The Amazon Resource Name (ARN) of the IAM service role that has permissions
    /// to add data to your output Amazon S3 bucket and add metrics to Amazon
    /// CloudWatch. For more information, see [Measuring impact of
    /// recommendations](https://docs.aws.amazon.com/personalize/latest/dg/measuring-recommendation-impact.html).
    role_arn: []const u8,

    s_3_data_destination: ?S3DataConfig,

    pub const json_field_names = .{
        .role_arn = "roleArn",
        .s_3_data_destination = "s3DataDestination",
    };
};
