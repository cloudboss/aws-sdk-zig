const InsightsFailureSignal = @import("insights_failure_signal.zig").InsightsFailureSignal;

/// Details about a specific span where a failure was detected.
pub const FailureSpanDetail = struct {
    /// The failure signals detected in this span.
    signals: []const InsightsFailureSignal,

    /// The unique identifier of the span where the failure occurred.
    span_id: []const u8,

    /// The trace identifier associated with the failure span.
    trace_id: []const u8,

    pub const json_field_names = .{
        .signals = "signals",
        .span_id = "spanId",
        .trace_id = "traceId",
    };
};
