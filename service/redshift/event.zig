const SourceType = @import("source_type.zig").SourceType;

/// Describes an event.
pub const Event = struct {
    /// The date and time of the event.
    date: ?i64,

    /// A list of the event categories.
    ///
    /// Values: Configuration, Management, Monitoring, Security, Pending
    event_categories: ?[]const []const u8,

    /// The identifier of the event.
    event_id: ?[]const u8,

    /// The text of this event.
    message: ?[]const u8,

    /// The severity of the event.
    ///
    /// Values: ERROR, INFO
    severity: ?[]const u8,

    /// The identifier for the source of the event.
    source_identifier: ?[]const u8,

    /// The source type for this event.
    source_type: ?SourceType,
};
