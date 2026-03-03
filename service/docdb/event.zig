const SourceType = @import("source_type.zig").SourceType;

/// Detailed information about an event.
pub const Event = struct {
    /// Specifies the date and time of the event.
    date: ?i64 = null,

    /// Specifies the category for the event.
    event_categories: ?[]const []const u8 = null,

    /// Provides the text of this event.
    message: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the event.
    source_arn: ?[]const u8 = null,

    /// Provides the identifier for the source of the event.
    source_identifier: ?[]const u8 = null,

    /// Specifies the source type for this event.
    source_type: ?SourceType = null,
};
