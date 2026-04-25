/// Provides information about the logging status of the cluster.
pub const AwsRedshiftClusterLoggingStatus = struct {
    /// The name of the S3 bucket where the log files are stored.
    bucket_name: ?[]const u8 = null,

    /// The message indicating that the logs failed to be delivered.
    last_failure_message: ?[]const u8 = null,

    /// The last time when logs failed to be delivered.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub CSPM, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    last_failure_time: ?[]const u8 = null,

    /// The last time that logs were delivered successfully.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub CSPM, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    last_successful_delivery_time: ?[]const u8 = null,

    /// Indicates whether logging is enabled.
    logging_enabled: ?bool = null,

    /// Provides the prefix applied to the log file names.
    s3_key_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket_name = "BucketName",
        .last_failure_message = "LastFailureMessage",
        .last_failure_time = "LastFailureTime",
        .last_successful_delivery_time = "LastSuccessfulDeliveryTime",
        .logging_enabled = "LoggingEnabled",
        .s3_key_prefix = "S3KeyPrefix",
    };
};
