const RemediationActionType = @import("remediation_action_type.zig").RemediationActionType;
const SecurityGroupRuleDescription = @import("security_group_rule_description.zig").SecurityGroupRuleDescription;

/// Remediation option for the rule specified in the `ViolationTarget`.
pub const SecurityGroupRemediationAction = struct {
    /// Brief description of the action that will be performed.
    description: ?[]const u8,

    /// Indicates if the current action is the default action.
    is_default_action: bool = false,

    /// The remediation action that will be performed.
    remediation_action_type: ?RemediationActionType,

    /// The final state of the rule specified in the `ViolationTarget` after it is
    /// remediated.
    remediation_result: ?SecurityGroupRuleDescription,

    pub const json_field_names = .{
        .description = "Description",
        .is_default_action = "IsDefaultAction",
        .remediation_action_type = "RemediationActionType",
        .remediation_result = "RemediationResult",
    };
};
