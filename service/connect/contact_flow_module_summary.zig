const ContactFlowModuleState = @import("contact_flow_module_state.zig").ContactFlowModuleState;

/// Contains summary information about a flow.
pub const ContactFlowModuleSummary = struct {
    /// The Amazon Resource Name (ARN) of the flow module.
    arn: ?[]const u8 = null,

    /// The identifier of the flow module.
    id: ?[]const u8 = null,

    /// The name of the flow module.
    name: ?[]const u8 = null,

    /// The type of flow module.
    state: ?ContactFlowModuleState = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .name = "Name",
        .state = "State",
    };
};
