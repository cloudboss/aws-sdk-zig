/// Event bridge configuration.
pub const EventBridgeConfiguration = struct {
    /// Event bridge flag.
    event_bridge_enabled: bool,

    pub const json_field_names = .{
        .event_bridge_enabled = "eventBridgeEnabled",
    };
};
