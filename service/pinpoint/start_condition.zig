const EventStartCondition = @import("event_start_condition.zig").EventStartCondition;
const SegmentCondition = @import("segment_condition.zig").SegmentCondition;

/// Specifies the conditions for the first activity in a journey. This activity
/// and its conditions determine which users are participants in a journey.
pub const StartCondition = struct {
    /// The custom description of the condition.
    description: ?[]const u8 = null,

    event_start_condition: ?EventStartCondition = null,

    /// The segment that's associated with the first activity in the journey. This
    /// segment determines which users are participants in the journey.
    segment_start_condition: ?SegmentCondition = null,

    pub const json_field_names = .{
        .description = "Description",
        .event_start_condition = "EventStartCondition",
        .segment_start_condition = "SegmentStartCondition",
    };
};
