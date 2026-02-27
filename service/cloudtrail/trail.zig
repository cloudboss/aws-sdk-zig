/// The settings for a trail.
pub const Trail = struct {
    /// Specifies an Amazon Resource Name (ARN), a unique identifier that represents
    /// the log
    /// group to which CloudTrail logs will be delivered.
    cloud_watch_logs_log_group_arn: ?[]const u8,

    /// Specifies the role for the CloudWatch Logs endpoint to assume to write to a
    /// user's
    /// log group.
    cloud_watch_logs_role_arn: ?[]const u8,

    /// Specifies if the trail has custom event selectors.
    has_custom_event_selectors: ?bool,

    /// Specifies whether a trail has insight types specified in an
    /// `InsightSelector`
    /// list.
    has_insight_selectors: ?bool,

    /// The Region in which the trail was created.
    home_region: ?[]const u8,

    /// Set to **True** to include Amazon Web Services API calls
    /// from Amazon Web Services global services such as IAM. Otherwise, **False**.
    include_global_service_events: ?bool,

    /// Specifies whether the trail exists only in one Region or exists in all
    /// Regions.
    is_multi_region_trail: ?bool,

    /// Specifies whether the trail is an organization trail.
    is_organization_trail: ?bool,

    /// Specifies the KMS key ID that encrypts the logs and digest files delivered
    /// by CloudTrail. The value is a fully specified ARN to a KMS key in the
    /// following format.
    ///
    /// `arn:aws:kms:us-east-2:123456789012:key/12345678-1234-1234-1234-123456789012`
    kms_key_id: ?[]const u8,

    /// Specifies whether log file validation is enabled.
    log_file_validation_enabled: ?bool,

    /// Name of the trail set by calling CreateTrail. The maximum length is
    /// 128 characters.
    name: ?[]const u8,

    /// Name of the Amazon S3 bucket into which CloudTrail delivers your trail
    /// files. See [Amazon S3
    /// Bucket naming
    /// rules](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html).
    s3_bucket_name: ?[]const u8,

    /// Specifies the Amazon S3 key prefix that comes after the name of the bucket
    /// you
    /// have designated for log file delivery. For more information, see [Finding
    /// Your CloudTrail Log
    /// Files](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/get-and-view-cloudtrail-log-files.html#cloudtrail-find-log-files). The maximum length is 200
    /// characters.
    s3_key_prefix: ?[]const u8,

    /// Specifies the ARN of the Amazon SNS topic that CloudTrail uses to send
    /// notifications when log files are delivered. The following is the format of a
    /// topic
    /// ARN.
    ///
    /// `arn:aws:sns:us-east-2:123456789012:MyTopic`
    sns_topic_arn: ?[]const u8,

    /// This field is no longer in use. Use `SnsTopicARN`.
    sns_topic_name: ?[]const u8,

    /// Specifies the ARN of the trail. The following is the format of a trail ARN.
    ///
    /// `arn:aws:cloudtrail:us-east-2:123456789012:trail/MyTrail`
    trail_arn: ?[]const u8,

    pub const json_field_names = .{
        .cloud_watch_logs_log_group_arn = "CloudWatchLogsLogGroupArn",
        .cloud_watch_logs_role_arn = "CloudWatchLogsRoleArn",
        .has_custom_event_selectors = "HasCustomEventSelectors",
        .has_insight_selectors = "HasInsightSelectors",
        .home_region = "HomeRegion",
        .include_global_service_events = "IncludeGlobalServiceEvents",
        .is_multi_region_trail = "IsMultiRegionTrail",
        .is_organization_trail = "IsOrganizationTrail",
        .kms_key_id = "KmsKeyId",
        .log_file_validation_enabled = "LogFileValidationEnabled",
        .name = "Name",
        .s3_bucket_name = "S3BucketName",
        .s3_key_prefix = "S3KeyPrefix",
        .sns_topic_arn = "SnsTopicARN",
        .sns_topic_name = "SnsTopicName",
        .trail_arn = "TrailARN",
    };
};
