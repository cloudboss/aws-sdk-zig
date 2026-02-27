const ActionDefinition = @import("action_definition.zig").ActionDefinition;

/// An optional, non-standard action to use for stateless packet handling. You
/// can define
/// this in addition to the standard action that you must specify.
///
/// You define and name the custom actions that you want to be able to use, and
/// then you
/// reference them by name in your actions settings.
///
/// You can use custom actions in the following places:
///
/// * In a rule group's StatelessRulesAndCustomActions specification.
/// The custom actions are available for use by name inside the
/// `StatelessRulesAndCustomActions` where you define them. You can use
/// them for your stateless rule actions to specify what to do with a packet
/// that matches
/// the rule's match attributes.
///
/// * In a FirewallPolicy specification, in
/// `StatelessCustomActions`. The custom actions are available for use
/// inside the policy where you define them. You can use them for the policy's
/// default
/// stateless actions settings to specify what to do with packets that don't
/// match any of
/// the policy's stateless rules.
pub const CustomAction = struct {
    /// The custom action associated with the action name.
    action_definition: ActionDefinition,

    /// The descriptive name of the custom action. You can't change the name of a
    /// custom action after you create it.
    action_name: []const u8,

    pub const json_field_names = .{
        .action_definition = "ActionDefinition",
        .action_name = "ActionName",
    };
};
