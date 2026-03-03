const EventInfoMap = @import("event_info_map.zig").EventInfoMap;

/// Describes event categories.
pub const EventCategoriesMap = struct {
    /// The events in the event category.
    events: ?[]const EventInfoMap = null,

    /// The source type, such as cluster or cluster-snapshot, that the returned
    /// categories
    /// belong to.
    source_type: ?[]const u8 = null,
};
