const StatelessCustomActionDefinition = @import("stateless_custom_action_definition.zig").StatelessCustomActionDefinition;

/// A custom action that can be used for stateless packet handling.
pub const FirewallPolicyStatelessCustomActionsDetails = struct {
    /// The definition of the custom action.
    action_definition: ?StatelessCustomActionDefinition = null,

    /// The name of the custom action.
    action_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .action_definition = "ActionDefinition",
        .action_name = "ActionName",
    };
};
