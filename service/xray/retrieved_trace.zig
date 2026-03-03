const Span = @import("span.zig").Span;

/// Retrieved collection of spans with matching trace IDs.
pub const RetrievedTrace = struct {
    /// The length of time in seconds between the start time of the root span and
    /// the end time of the last span that completed.
    duration: ?f64 = null,

    /// The unique identifier for the span.
    id: ?[]const u8 = null,

    /// Spans that comprise the trace.
    spans: ?[]const Span = null,

    pub const json_field_names = .{
        .duration = "Duration",
        .id = "Id",
        .spans = "Spans",
    };
};
