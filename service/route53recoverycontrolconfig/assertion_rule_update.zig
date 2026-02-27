/// An update to an assertion rule. You can update the name or the evaluation
/// period (wait period). If you don't specify one of the items to update, the
/// item is unchanged.
pub const AssertionRuleUpdate = struct {
    /// The name of the assertion rule. You can use any non-white space character in
    /// the name.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the assertion rule.
    safety_rule_arn: []const u8,

    /// An evaluation period, in milliseconds (ms), during which any request against
    /// the target routing controls will fail. This helps prevent "flapping" of
    /// state. The wait period is 5000 ms by default, but you can choose a custom
    /// value.
    wait_period_ms: i32,

    pub const json_field_names = .{
        .name = "Name",
        .safety_rule_arn = "SafetyRuleArn",
        .wait_period_ms = "WaitPeriodMs",
    };
};
