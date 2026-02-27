const StatelessCustomActionDefinition = @import("stateless_custom_action_definition.zig").StatelessCustomActionDefinition;

/// A custom action definition. A custom action is an optional, non-standard
/// action to use for stateless packet handling.
pub const RuleGroupSourceCustomActionsDetails = struct {
    /// The definition of a custom action.
    action_definition: ?StatelessCustomActionDefinition,

    /// A descriptive name of the custom action.
    action_name: ?[]const u8,

    pub const json_field_names = .{
        .action_definition = "ActionDefinition",
        .action_name = "ActionName",
    };
};
