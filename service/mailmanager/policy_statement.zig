const AcceptAction = @import("accept_action.zig").AcceptAction;
const PolicyCondition = @import("policy_condition.zig").PolicyCondition;

/// The structure containing traffic policy conditions and actions.
pub const PolicyStatement = struct {
    /// The action that informs a traffic policy resource to either allow or block
    /// the email if it matches a condition in the policy statement.
    action: AcceptAction,

    /// The list of conditions to apply to incoming messages for filtering email
    /// traffic.
    conditions: []const PolicyCondition,

    pub const json_field_names = .{
        .action = "Action",
        .conditions = "Conditions",
    };
};
