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
    /// * `system-logs`: EMR Daemon logs.
    ///
    /// * `application-logs`: Framework logs from Hadoop, Spark, Hive and other
    ///   applications running on the cluster.
    ///
    /// * `persistent-ui-logs`: Logs required for persistent application UIs such as
    ///   Spark History Server and Tez UI.
    ///
    /// Valid upload policies:
    ///
    /// * `emr-managed`: Standard behavior. Logs are uploaded to S3 bucket as
    ///   configured in your
    /// LogUri, with certain logs retained by the service for operational
    /// support and troubleshooting purposes.
    ///
    /// * `on-customer-s3only`: Logs are uploaded only to the customer-specified S3
    ///   bucket. This requires you to specify a LogUri
    /// when creating the cluster. Persistent-ui-logs cannot have
    /// on-customer-s3only policy. Allowed policies for persistent-ui-logs
    /// are emr-managed and disabled.
    ///
    /// * `disabled`: No S3 upload for this log type.
    log_type_upload_policy: ?[]const aws.map.MapEntry(LogUploadPolicyValue) = null,

    pub const json_field_names = .{
        .log_type_upload_policy = "LogTypeUploadPolicy",
    };
};
