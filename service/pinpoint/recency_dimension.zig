const Duration = @import("duration.zig").Duration;
const RecencyType = @import("recency_type.zig").RecencyType;

/// Specifies criteria for including or excluding endpoints from a segment based
/// on how recently an endpoint was active.
pub const RecencyDimension = struct {
    /// The duration to use when determining whether an endpoint is active or
    /// inactive.
    duration: Duration,

    /// The type of recency dimension to use for the segment. Valid values are:
    /// ACTIVE, endpoints that were active within the specified duration are
    /// included in the segment; and, INACTIVE, endpoints that weren't active within
    /// the specified duration are included in the segment.
    recency_type: RecencyType,

    pub const json_field_names = .{
        .duration = "Duration",
        .recency_type = "RecencyType",
    };
};
