/// Data about the stored events.
pub const IngestedEventStatistics = struct {
    /// The total size of the stored events.
    event_data_size_in_bytes: ?i64 = null,

    /// Timestamp of when the stored event was last updated.
    last_updated_time: ?[]const u8 = null,

    /// The oldest stored event.
    least_recent_event: ?[]const u8 = null,

    /// The newest stored event.
    most_recent_event: ?[]const u8 = null,

    /// The number of stored events.
    number_of_events: ?i64 = null,

    pub const json_field_names = .{
        .event_data_size_in_bytes = "eventDataSizeInBytes",
        .last_updated_time = "lastUpdatedTime",
        .least_recent_event = "leastRecentEvent",
        .most_recent_event = "mostRecentEvent",
        .number_of_events = "numberOfEvents",
    };
};
