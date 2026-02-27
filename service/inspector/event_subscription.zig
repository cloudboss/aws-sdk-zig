const InspectorEvent = @import("inspector_event.zig").InspectorEvent;

/// This data type is used in the Subscription data type.
pub const EventSubscription = struct {
    /// The event for which Amazon Simple Notification Service (SNS) notifications
    /// are
    /// sent.
    event: InspectorEvent,

    /// The time at which SubscribeToEvent is called.
    subscribed_at: i64,

    pub const json_field_names = .{
        .event = "event",
        .subscribed_at = "subscribedAt",
    };
};
