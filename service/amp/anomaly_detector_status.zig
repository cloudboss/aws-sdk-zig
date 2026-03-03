const AnomalyDetectorStatusCode = @import("anomaly_detector_status_code.zig").AnomalyDetectorStatusCode;

/// The status information of an anomaly detector.
pub const AnomalyDetectorStatus = struct {
    /// The status code of the anomaly detector.
    status_code: AnomalyDetectorStatusCode,

    /// A description of the current status of the anomaly detector.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .status_code = "statusCode",
        .status_reason = "statusReason",
    };
};
