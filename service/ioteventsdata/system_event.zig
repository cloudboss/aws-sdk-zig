const EventType = @import("event_type.zig").EventType;
const StateChangeConfiguration = @import("state_change_configuration.zig").StateChangeConfiguration;

/// Contains information about alarm state changes.
pub const SystemEvent = struct {
    /// The event type. If the value is `STATE_CHANGE`, the event contains
    /// information
    /// about alarm state changes.
    event_type: ?EventType,

    /// Contains the configuration information of alarm state changes.
    state_change_configuration: ?StateChangeConfiguration,

    pub const json_field_names = .{
        .event_type = "eventType",
        .state_change_configuration = "stateChangeConfiguration",
    };
};
