const AnomalyScore = @import("anomaly_score.zig").AnomalyScore;
const AnomalyFeedbackType = @import("anomaly_feedback_type.zig").AnomalyFeedbackType;
const Impact = @import("impact.zig").Impact;
const RootCause = @import("root_cause.zig").RootCause;

/// An unusual cost pattern. This consists of the detailed metadata and the
/// current status
/// of the anomaly object.
pub const Anomaly = struct {
    /// The last day the anomaly is detected.
    anomaly_end_date: ?[]const u8 = null,

    /// The unique identifier for the anomaly.
    anomaly_id: []const u8,

    /// The latest and maximum score for the anomaly.
    anomaly_score: AnomalyScore,

    /// The first day the anomaly is detected.
    anomaly_start_date: ?[]const u8 = null,

    /// The dimension for the anomaly (for example, an Amazon Web Services service
    /// in a service
    /// monitor).
    dimension_value: ?[]const u8 = null,

    /// The feedback value.
    feedback: ?AnomalyFeedbackType = null,

    /// The dollar impact for the anomaly.
    impact: Impact,

    /// The Amazon Resource Name (ARN) for the cost monitor that generated this
    /// anomaly.
    monitor_arn: []const u8,

    /// The list of identified root causes for the anomaly.
    root_causes: ?[]const RootCause = null,

    pub const json_field_names = .{
        .anomaly_end_date = "AnomalyEndDate",
        .anomaly_id = "AnomalyId",
        .anomaly_score = "AnomalyScore",
        .anomaly_start_date = "AnomalyStartDate",
        .dimension_value = "DimensionValue",
        .feedback = "Feedback",
        .impact = "Impact",
        .monitor_arn = "MonitorArn",
        .root_causes = "RootCauses",
    };
};
