const RecencyDimension = @import("recency_dimension.zig").RecencyDimension;

/// Specifies dimension settings for including or excluding endpoints from a
/// segment based on how recently an endpoint was active.
pub const SegmentBehaviors = struct {
    /// The dimension settings that are based on how recently an endpoint was
    /// active.
    recency: ?RecencyDimension,

    pub const json_field_names = .{
        .recency = "Recency",
    };
};
