const aws = @import("aws");

/// The Amazon CloudWatch configuration for monitoring logs. You can configure
/// your jobs to send log information to CloudWatch.
pub const CloudWatchLoggingConfiguration = struct {
    /// Enables CloudWatch logging.
    enabled: bool,

    /// The Key Management Service (KMS) key ARN to encrypt the logs that you store
    /// in CloudWatch Logs.
    encryption_key_arn: ?[]const u8,

    /// The name of the log group in Amazon CloudWatch Logs where you want to
    /// publish your logs.
    log_group_name: ?[]const u8,

    /// Prefix for the CloudWatch log stream name.
    log_stream_name_prefix: ?[]const u8,

    /// The types of logs that you want to publish to CloudWatch. If you don't
    /// specify any log types, driver STDOUT and STDERR logs will be published to
    /// CloudWatch Logs by default. For more information including the supported
    /// worker types for Hive and Spark, see [Logging for EMR Serverless with
    /// CloudWatch](https://docs.aws.amazon.com/emr/latest/EMR-Serverless-UserGuide/logging.html#jobs-log-storage-cw).
    ///
    /// * **Key Valid Values**: `SPARK_DRIVER`, `SPARK_EXECUTOR`, `HIVE_DRIVER`,
    ///   `TEZ_TASK`
    /// * **Array Members Valid Values**: `STDOUT`, `STDERR`, `HIVE_LOG`, `TEZ_AM`,
    ///   `SYSTEM_LOGS`
    log_types: ?[]const aws.map.MapEntry([]const []const u8),

    pub const json_field_names = .{
        .enabled = "enabled",
        .encryption_key_arn = "encryptionKeyArn",
        .log_group_name = "logGroupName",
        .log_stream_name_prefix = "logStreamNamePrefix",
        .log_types = "logTypes",
    };
};
