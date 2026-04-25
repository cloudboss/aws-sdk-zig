const aws = @import("aws");

const LogUploadPolicyValue = @import("log_upload_policy_value.zig").LogUploadPolicyValue;

/// Configuration for S3 logging behavior in EMR clusters. Defines how different
/// types of logs are uploaded to S3 based on the specified upload policies for
/// each log type.
pub const S3LoggingConfiguration = struct {
    /// A map that specifies the upload policy for each log type. The key is the log
    /// type, and the value is the upload policy.
    ///
    /// Valid log types:
    ///
    /// * `system-logs`: System-level logs including daemon logs, bootstrap logs,
    ///   and other infrastructure logs.
    ///
    /// * `application-logs`: Application-level logs from frameworks like Hadoop,
    ///   Spark, Hive, etc.
    ///
    /// * `persistent-ui-logs`: Logs for persistent application UIs like Spark
    ///   History Server.
    ///
    /// Valid upload policies:
    ///
    /// * `emr-managed`: Logs are uploaded to both the EMR-managed S3 bucket and the
    ///   customer-specified S3 bucket (if LogUri is provided).
    ///
    /// * `on-customer-s3only`: Logs are uploaded only to the customer-specified S3
    ///   bucket. Requires LogUri to be specified in the cluster configuration.
    ///
    /// * `disabled`: Log upload is disabled for this log type.
    log_type_upload_policy: ?[]const aws.map.MapEntry(LogUploadPolicyValue) = null,

    pub const json_field_names = .{
        .log_type_upload_policy = "LogTypeUploadPolicy",
    };
};
