const RejectRuleBehavior = @import("reject_rule_behavior.zig").RejectRuleBehavior;

/// Specifies the rule and the threshold under which a prediction can be
/// rejected.
pub const RejectRule = struct {
    /// Specifies whether you want to reject the top prediction for all targets or
    /// none.
    rule: ?RejectRuleBehavior = null,

    /// The confidence score that specifies the condition at which a prediction can
    /// be rejected.
    threshold: ?f32 = null,

    pub const json_field_names = .{
        .rule = "rule",
        .threshold = "threshold",
    };
};
