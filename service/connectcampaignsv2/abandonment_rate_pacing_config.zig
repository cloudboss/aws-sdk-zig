const ConnectionStartPoint = @import("connection_start_point.zig").ConnectionStartPoint;

/// Configuration for abandonment-rate-based dialer throttling.
pub const AbandonmentRatePacingConfig = struct {
    /// Event from which connectionThresholdSeconds is measured.
    connection_start_point: ConnectionStartPoint,

    /// Seconds after connectionStartPoint before a contact counts as abandoned.
    connection_threshold_seconds: i32,

    /// Rolling window over which abandonmentRate is computed.
    evaluation_window: []const u8,

    target_rate: f64,

    pub const json_field_names = .{
        .connection_start_point = "connectionStartPoint",
        .connection_threshold_seconds = "connectionThresholdSeconds",
        .evaluation_window = "evaluationWindow",
        .target_rate = "targetRate",
    };
};
