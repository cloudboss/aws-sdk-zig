const EventCondition = @import("event_condition.zig").EventCondition;
const SegmentCondition = @import("segment_condition.zig").SegmentCondition;
const SegmentDimensions = @import("segment_dimensions.zig").SegmentDimensions;

/// Specifies a condition to evaluate for an activity in a journey.
pub const SimpleCondition = struct {
    /// The dimension settings for the event that's associated with the activity.
    event_condition: ?EventCondition = null,

    /// The segment that's associated with the activity.
    segment_condition: ?SegmentCondition = null,

    /// The dimension settings for the segment that's associated with the activity.
    segment_dimensions: ?SegmentDimensions = null,

    pub const json_field_names = .{
        .event_condition = "EventCondition",
        .segment_condition = "SegmentCondition",
        .segment_dimensions = "SegmentDimensions",
    };
};
