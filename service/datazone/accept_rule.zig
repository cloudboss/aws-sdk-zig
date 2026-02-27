const AcceptRuleBehavior = @import("accept_rule_behavior.zig").AcceptRuleBehavior;

/// Specifies the rule and the threshold under which a prediction can be
/// accepted.
pub const AcceptRule = struct {
    /// Specifies whether you want to accept the top prediction for all targets or
    /// none.
    rule: ?AcceptRuleBehavior,

    /// The confidence score that specifies the condition at which a prediction can
    /// be accepted.
    threshold: ?f32,

    pub const json_field_names = .{
        .rule = "rule",
        .threshold = "threshold",
    };
};
