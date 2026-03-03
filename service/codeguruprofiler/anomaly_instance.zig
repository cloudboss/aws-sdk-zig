const UserFeedback = @import("user_feedback.zig").UserFeedback;

/// The specific duration in which the metric is flagged as anomalous.
pub const AnomalyInstance = struct {
    /// The end time of the period during which the metric is flagged as anomalous.
    /// This is specified
    /// using the ISO 8601 format. For example, 2020-06-01T13:15:02.001Z represents
    /// 1
    /// millisecond past June 1, 2020 1:15:02 PM UTC.
    end_time: ?i64 = null,

    /// The universally unique identifier (UUID) of an instance of an anomaly in a
    /// metric.
    id: []const u8,

    /// The start time of the period during which the metric is flagged as
    /// anomalous.
    /// This is specified
    /// using the ISO 8601 format. For example, 2020-06-01T13:15:02.001Z represents
    /// 1
    /// millisecond past June 1, 2020 1:15:02 PM UTC.
    start_time: i64,

    /// Feedback type on a specific instance of anomaly submitted by the user.
    user_feedback: ?UserFeedback = null,

    pub const json_field_names = .{
        .end_time = "endTime",
        .id = "id",
        .start_time = "startTime",
        .user_feedback = "userFeedback",
    };
};
