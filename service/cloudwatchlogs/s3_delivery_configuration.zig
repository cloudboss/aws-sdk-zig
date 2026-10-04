/// This structure contains delivery configurations that apply only when the
/// delivery
/// destination resource is an S3 bucket.
pub const S3DeliveryConfiguration = struct {
    /// This parameter causes the S3 objects that contain delivered logs to use a
    /// prefix structure
    /// that allows for integration with Apache Hive.
    enable_hive_compatible_path: ?bool = null,

    /// This string allows re-configuring the S3 object prefix to contain either
    /// static or
    /// variable sections. The valid variables to use in the suffix path vary by log
    /// type. To find the
    /// values supported for the suffix path for each log type, use the
    /// [DescribeConfigurationTemplates](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_DescribeConfigurationTemplates.html) operation and check the
    /// `allowedSuffixPathFields` field in the response. For more information about
    /// how
    /// the destination prefix, suffix path, and Hive-compatible setting determine
    /// the Amazon S3 object
    /// key, see [Amazon S3 object key for V2
    /// deliveries](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/AWS-logs-infrastructure-V2-S3.html#AWS-logs-infrastructure-V2-S3-object-key).
    suffix_path: ?[]const u8 = null,

    pub const json_field_names = .{
        .enable_hive_compatible_path = "enableHiveCompatiblePath",
        .suffix_path = "suffixPath",
    };
};
