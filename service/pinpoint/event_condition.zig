const EventDimensions = @import("event_dimensions.zig").EventDimensions;

/// Specifies the conditions to evaluate for an event that applies to an
/// activity in a journey.
pub const EventCondition = struct {
    /// The dimensions for the event filter to use for the activity.
    dimensions: ?EventDimensions,

    /// The message identifier (message_id) for the message to use when determining
    /// whether message events meet the condition.
    message_activity: ?[]const u8,

    pub const json_field_names = .{
        .dimensions = "Dimensions",
        .message_activity = "MessageActivity",
    };
};
