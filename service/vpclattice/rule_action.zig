const FixedResponseAction = @import("fixed_response_action.zig").FixedResponseAction;
const ForwardAction = @import("forward_action.zig").ForwardAction;

/// Describes the action for a rule.
pub const RuleAction = union(enum) {
    /// The fixed response action. The rule returns a custom HTTP response.
    fixed_response: ?FixedResponseAction,
    /// The forward action. Traffic that matches the rule is forwarded to the
    /// specified target groups.
    forward: ?ForwardAction,

    pub const json_field_names = .{
        .fixed_response = "fixedResponse",
        .forward = "forward",
    };
};
