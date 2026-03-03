const Segment = @import("segment.zig").Segment;

/// A collection of segment documents with matching trace IDs.
pub const Trace = struct {
    /// The length of time in seconds between the start time of the earliest segment
    /// that started and the end time of the last segment that completed.
    duration: ?f64 = null,

    /// The unique identifier for the request that generated the trace's segments
    /// and
    /// subsegments.
    id: ?[]const u8 = null,

    /// LimitExceeded is set to true when the trace has exceeded the `Trace document
    /// size` limit. For
    /// more information about this limit and other X-Ray limits and quotas, see
    /// [Amazon Web Services X-Ray endpoints and
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/xray.html).
    limit_exceeded: ?bool = null,

    /// Segment documents for the segments and subsegments that comprise the trace.
    segments: ?[]const Segment = null,

    pub const json_field_names = .{
        .duration = "Duration",
        .id = "Id",
        .limit_exceeded = "LimitExceeded",
        .segments = "Segments",
    };
};
