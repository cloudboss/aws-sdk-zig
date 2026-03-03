const RemediationAction = @import("remediation_action.zig").RemediationAction;

/// An ordered list of actions you can take to remediate a violation.
pub const RemediationActionWithOrder = struct {
    /// The order of the remediation actions in the list.
    order: i32 = 0,

    /// Information about an action you can take to remediate a violation.
    remediation_action: ?RemediationAction = null,

    pub const json_field_names = .{
        .order = "Order",
        .remediation_action = "RemediationAction",
    };
};
