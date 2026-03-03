/// Provides details about a CloudTrail trail.
pub const AwsCloudTrailTrailDetails = struct {
    /// The ARN of the log group that CloudTrail logs are delivered to.
    cloud_watch_logs_log_group_arn: ?[]const u8 = null,

    /// The ARN of the role that the CloudWatch Events endpoint assumes when it
    /// writes to the log
    /// group.
    cloud_watch_logs_role_arn: ?[]const u8 = null,

    /// Indicates whether the trail has custom event selectors.
    has_custom_event_selectors: ?bool = null,

    /// The Region where the trail was created.
    home_region: ?[]const u8 = null,

    /// Indicates whether the trail publishes events from global services such as
    /// IAM to the log
    /// files.
    include_global_service_events: ?bool = null,

    /// Indicates whether the trail applies only to the current Region or to all
    /// Regions.
    is_multi_region_trail: ?bool = null,

    /// Whether the trail is created for all accounts in an organization in
    /// Organizations,
    /// or only for the current Amazon Web Services account.
    is_organization_trail: ?bool = null,

    /// The KMS key ID to use to encrypt the logs.
    kms_key_id: ?[]const u8 = null,

    /// Indicates whether CloudTrail log file validation is enabled.
    log_file_validation_enabled: ?bool = null,

    /// The name of the trail.
    name: ?[]const u8 = null,

    /// The name of the S3 bucket where the log files are published.
    s3_bucket_name: ?[]const u8 = null,

    /// The S3 key prefix. The key prefix is added after the name of the S3 bucket
    /// where the log
    /// files are published.
    s3_key_prefix: ?[]const u8 = null,

    /// The ARN of the SNS topic that is used for notifications of log file
    /// delivery.
    sns_topic_arn: ?[]const u8 = null,

    /// The name of the SNS topic that is used for notifications of log file
    /// delivery.
    sns_topic_name: ?[]const u8 = null,

    /// The ARN of the trail.
    trail_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .cloud_watch_logs_log_group_arn = "CloudWatchLogsLogGroupArn",
        .cloud_watch_logs_role_arn = "CloudWatchLogsRoleArn",
        .has_custom_event_selectors = "HasCustomEventSelectors",
        .home_region = "HomeRegion",
        .include_global_service_events = "IncludeGlobalServiceEvents",
        .is_multi_region_trail = "IsMultiRegionTrail",
        .is_organization_trail = "IsOrganizationTrail",
        .kms_key_id = "KmsKeyId",
        .log_file_validation_enabled = "LogFileValidationEnabled",
        .name = "Name",
        .s3_bucket_name = "S3BucketName",
        .s3_key_prefix = "S3KeyPrefix",
        .sns_topic_arn = "SnsTopicArn",
        .sns_topic_name = "SnsTopicName",
        .trail_arn = "TrailArn",
    };
};
