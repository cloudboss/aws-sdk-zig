const AnomalyDetectorStatus = @import("anomaly_detector_status.zig").AnomalyDetectorStatus;
const EvaluationFrequency = @import("evaluation_frequency.zig").EvaluationFrequency;

/// Contains information about one anomaly detector in the account.
pub const AnomalyDetector = struct {
    /// The ARN of the anomaly detector.
    anomaly_detector_arn: ?[]const u8 = null,

    /// Specifies the current status of the anomaly detector. To pause an anomaly
    /// detector, use
    /// the `enabled` parameter in the
    /// [UpdateLogAnomalyDetector](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_UpdateLogAnomalyDetector.html) operation.
    anomaly_detector_status: ?AnomalyDetectorStatus = null,

    /// The number of days used as the life cycle of anomalies. After this time,
    /// anomalies are
    /// automatically baselined and the anomaly detector model will treat new
    /// occurrences of similar
    /// event as normal.
    anomaly_visibility_time: ?i64 = null,

    /// The date and time when this anomaly detector was created.
    creation_time_stamp: i64 = 0,

    /// The name of the anomaly detector.
    detector_name: ?[]const u8 = null,

    /// Specifies how often the anomaly detector runs and look for anomalies.
    evaluation_frequency: ?EvaluationFrequency = null,

    filter_pattern: ?[]const u8 = null,

    /// The ARN of the KMS key assigned to this anomaly detector, if any.
    kms_key_id: ?[]const u8 = null,

    /// The date and time when this anomaly detector was most recently modified.
    last_modified_time_stamp: i64 = 0,

    /// A list of the ARNs of the log groups that this anomaly detector watches.
    log_group_arn_list: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .anomaly_detector_arn = "anomalyDetectorArn",
        .anomaly_detector_status = "anomalyDetectorStatus",
        .anomaly_visibility_time = "anomalyVisibilityTime",
        .creation_time_stamp = "creationTimeStamp",
        .detector_name = "detectorName",
        .evaluation_frequency = "evaluationFrequency",
        .filter_pattern = "filterPattern",
        .kms_key_id = "kmsKeyId",
        .last_modified_time_stamp = "lastModifiedTimeStamp",
        .log_group_arn_list = "logGroupArnList",
    };
};
