const EventType = @import("event_type.zig").EventType;

/// Structure describing a notification configuration.
pub const NotificationConfigurationSummary = struct {
    /// The name of the destination for the notification configuration.
    destination_name: ?[]const u8 = null,

    /// The type of event triggering a device notification to the customer-managed
    /// destination.
    event_type: ?EventType = null,

    pub const json_field_names = .{
        .destination_name = "DestinationName",
        .event_type = "EventType",
    };
};
