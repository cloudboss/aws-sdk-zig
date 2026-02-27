/// The event orchestration status.
pub const EventOrchestration = struct {
    /// Specifies if event orchestration is enabled through Amazon EventBridge.
    event_bridge_enabled: bool,

    pub const json_field_names = .{
        .event_bridge_enabled = "eventBridgeEnabled",
    };
};
