/// Action for an Amazon Web Services capability, containing the action
/// parameters for control.
pub const CapabilityAction = struct {
    /// Describe a capability action with an `actionTraceId` for a response command.
    action_trace_id: ?[]const u8,

    /// Describe a capability action with a name.
    name: []const u8,

    /// Describe a capability action with a capability property.
    parameters: ?[]const u8,

    /// Describe a capability action with an reference.
    ref: ?[]const u8,

    pub const json_field_names = .{
        .action_trace_id = "actionTraceId",
        .name = "name",
        .parameters = "parameters",
        .ref = "ref",
    };
};
