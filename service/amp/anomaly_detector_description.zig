const aws = @import("aws");

const AnomalyDetectorConfiguration = @import("anomaly_detector_configuration.zig").AnomalyDetectorConfiguration;
const AnomalyDetectorMissingDataAction = @import("anomaly_detector_missing_data_action.zig").AnomalyDetectorMissingDataAction;
const AnomalyDetectorStatus = @import("anomaly_detector_status.zig").AnomalyDetectorStatus;

/// Detailed information about an anomaly detector.
pub const AnomalyDetectorDescription = struct {
    /// The user-friendly name of the anomaly detector.
    alias: []const u8,

    /// The unique identifier of the anomaly detector.
    anomaly_detector_id: []const u8,

    /// The Amazon Resource Name (ARN) of the anomaly detector.
    arn: []const u8,

    /// The algorithm configuration of the anomaly detector.
    configuration: ?AnomalyDetectorConfiguration = null,

    /// The timestamp when the anomaly detector was created.
    created_at: i64,

    /// The frequency, in seconds, at which the anomaly detector evaluates metrics.
    evaluation_interval_in_seconds: ?i32 = null,

    /// The Amazon Managed Service for Prometheus metric labels associated with the
    /// anomaly detector.
    labels: ?[]const aws.map.StringMapEntry = null,

    /// The action taken when data is missing during evaluation.
    missing_data_action: ?AnomalyDetectorMissingDataAction = null,

    /// The timestamp when the anomaly detector was last modified.
    modified_at: i64,

    /// The current status of the anomaly detector.
    status: AnomalyDetectorStatus,

    /// The tags applied to the anomaly detector.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .alias = "alias",
        .anomaly_detector_id = "anomalyDetectorId",
        .arn = "arn",
        .configuration = "configuration",
        .created_at = "createdAt",
        .evaluation_interval_in_seconds = "evaluationIntervalInSeconds",
        .labels = "labels",
        .missing_data_action = "missingDataAction",
        .modified_at = "modifiedAt",
        .status = "status",
        .tags = "tags",
    };
};
