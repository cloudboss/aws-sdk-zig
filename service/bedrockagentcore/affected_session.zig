const FailureSpanDetail = @import("failure_span_detail.zig").FailureSpanDetail;

/// A session affected by a detected failure pattern, including root cause
/// details.
pub const AffectedSession = struct {
    /// An explanation of how the failure manifested in this session.
    explanation: []const u8,

    /// The list of spans where failures were detected in this session.
    failure_spans: []const FailureSpanDetail,

    /// The type of fix recommended for this failure.
    fix_type: []const u8,

    /// The specific fix recommendation for this session.
    recommendation: []const u8,

    /// The unique identifier of the affected session.
    session_id: []const u8,

    pub const json_field_names = .{
        .explanation = "explanation",
        .failure_spans = "failureSpans",
        .fix_type = "fixType",
        .recommendation = "recommendation",
        .session_id = "sessionId",
    };
};
