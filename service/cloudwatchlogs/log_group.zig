const DataProtectionStatus = @import("data_protection_status.zig").DataProtectionStatus;
const InheritedProperty = @import("inherited_property.zig").InheritedProperty;
const LogGroupClass = @import("log_group_class.zig").LogGroupClass;

/// Represents a log group.
pub const LogGroup = struct {
    /// The Amazon Resource Name (ARN) of the log group. This version of the ARN
    /// includes a
    /// trailing `:*` after the log group name.
    ///
    /// Use this version to refer to the ARN in IAM policies when specifying
    /// permissions for most API actions. The exception is when specifying
    /// permissions for
    /// [TagResource](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_TagResource.html), [UntagResource](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_UntagResource.html),
    /// and
    /// [ListTagsForResource](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_ListTagsForResource.html). The permissions for those three actions require the ARN
    /// version that doesn't include a trailing `:*`.
    arn: ?[]const u8,

    /// The creation time of the log group, expressed as the number of milliseconds
    /// after Jan
    /// 1, 1970 00:00:00 UTC.
    creation_time: ?i64,

    /// Displays whether this log group has a protection policy, or whether it had
    /// one in the
    /// past. For more information, see
    /// [PutDataProtectionPolicy](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutDataProtectionPolicy.html).
    data_protection_status: ?DataProtectionStatus,

    /// Indicates whether deletion protection is enabled for this log group. When
    /// enabled,
    /// deletion protection blocks all deletion operations until it is explicitly
    /// disabled.
    deletion_protection_enabled: ?bool,

    /// Displays all the properties that this log group has inherited from
    /// account-level
    /// settings.
    inherited_properties: ?[]const InheritedProperty,

    /// The Amazon Resource Name (ARN) of the KMS key to use when
    /// encrypting log data.
    kms_key_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the log group. This version of the ARN
    /// doesn't
    /// include a trailing `:*` after the log group name.
    ///
    /// Use this version to refer to the ARN in the following situations:
    ///
    /// * In the `logGroupIdentifier` input field in many CloudWatch Logs
    /// APIs.
    ///
    /// * In the `resourceArn` field in tagging APIs
    ///
    /// * In IAM policies, when specifying permissions for
    ///   [TagResource](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_TagResource.html), [UntagResource](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_UntagResource.html), and [ListTagsForResource](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_ListTagsForResource.html).
    log_group_arn: ?[]const u8,

    /// This specifies the log group class for this log group. There are three
    /// classes:
    ///
    /// * The `Standard` log class supports all CloudWatch Logs features.
    ///
    /// * The `Infrequent Access` log class supports a subset of CloudWatch Logs
    /// features and incurs lower costs.
    ///
    /// * Use the `Delivery` log class only for delivering Lambda
    /// logs to store in Amazon S3 or Amazon Data Firehose. Log events in log groups
    /// in
    /// the Delivery class are kept in CloudWatch Logs for only one day. This log
    /// class doesn't
    /// offer rich CloudWatch Logs capabilities such as CloudWatch Logs Insights
    /// queries.
    ///
    /// For details about the features supported by the Standard and Infrequent
    /// Access classes,
    /// see [Log
    /// classes](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch_Logs_Log_Classes.html)
    log_group_class: ?LogGroupClass,

    /// The name of the log group.
    log_group_name: ?[]const u8,

    /// The number of metric filters.
    metric_filter_count: ?i32,

    retention_in_days: ?i32,

    /// The number of bytes stored.
    stored_bytes: ?i64,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .data_protection_status = "dataProtectionStatus",
        .deletion_protection_enabled = "deletionProtectionEnabled",
        .inherited_properties = "inheritedProperties",
        .kms_key_id = "kmsKeyId",
        .log_group_arn = "logGroupArn",
        .log_group_class = "logGroupClass",
        .log_group_name = "logGroupName",
        .metric_filter_count = "metricFilterCount",
        .retention_in_days = "retentionInDays",
        .stored_bytes = "storedBytes",
    };
};
