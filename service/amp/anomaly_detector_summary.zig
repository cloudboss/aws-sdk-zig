const aws = @import("aws");

const AnomalyDetectorStatus = @import("anomaly_detector_status.zig").AnomalyDetectorStatus;

/// Summary information about an anomaly detector for list operations.
pub const AnomalyDetectorSummary = struct {
    /// The user-friendly name of the anomaly detector.
    alias: []const u8,

    /// The unique identifier of the anomaly detector.
    anomaly_detector_id: []const u8,

    /// The Amazon Resource Name (ARN) of the anomaly detector.
    arn: []const u8,

    /// The timestamp when the anomaly detector was created.
    created_at: i64,

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
        .created_at = "createdAt",
        .modified_at = "modifiedAt",
        .status = "status",
        .tags = "tags",
    };
};
