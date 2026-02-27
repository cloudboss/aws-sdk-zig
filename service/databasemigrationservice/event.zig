const SourceType = @import("source_type.zig").SourceType;

/// Describes an identifiable significant activity that affects a replication
/// instance or
/// task. This object can provide the message, the available event categories,
/// the date and
/// source of the event, and the DMS resource type.
pub const Event = struct {
    /// The date of the event.
    date: ?i64,

    /// The event categories available for the specified source type.
    event_categories: ?[]const []const u8,

    /// The event message.
    message: ?[]const u8,

    /// The identifier of an event source.
    source_identifier: ?[]const u8,

    /// The type of DMS resource that generates events.
    ///
    /// Valid values: replication-instance | endpoint | replication-task
    source_type: ?SourceType,

    pub const json_field_names = .{
        .date = "Date",
        .event_categories = "EventCategories",
        .message = "Message",
        .source_identifier = "SourceIdentifier",
        .source_type = "SourceType",
    };
};
