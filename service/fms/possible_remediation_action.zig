const RemediationActionWithOrder = @import("remediation_action_with_order.zig").RemediationActionWithOrder;

/// A list of remediation actions.
pub const PossibleRemediationAction = struct {
    /// A description of the list of remediation actions.
    description: ?[]const u8,

    /// Information about whether an action is taken by default.
    is_default_action: bool = false,

    /// The ordered list of remediation actions.
    ordered_remediation_actions: []const RemediationActionWithOrder,

    pub const json_field_names = .{
        .description = "Description",
        .is_default_action = "IsDefaultAction",
        .ordered_remediation_actions = "OrderedRemediationActions",
    };
};
