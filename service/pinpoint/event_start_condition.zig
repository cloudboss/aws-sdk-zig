const EventFilter = @import("event_filter.zig").EventFilter;

/// Specifies the settings for an event that causes a journey activity to start.
pub const EventStartCondition = struct {
    event_filter: ?EventFilter = null,

    segment_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .event_filter = "EventFilter",
        .segment_id = "SegmentId",
    };
};
