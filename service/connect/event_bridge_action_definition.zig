/// The EventBridge action definition.
pub const EventBridgeActionDefinition = struct {
    /// The name.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};
