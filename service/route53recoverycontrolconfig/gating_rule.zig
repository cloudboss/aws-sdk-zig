const RuleConfig = @import("rule_config.zig").RuleConfig;
const Status = @import("status.zig").Status;

/// A gating rule verifies that a gating routing control or set of gating
/// routing controls, evaluates as true, based on a rule configuration that you
/// specify, which allows a set of routing control state changes to complete.
///
/// For example, if you specify one gating routing control and you set the Type
/// in the rule configuration to OR, that indicates that you must set the gating
/// routing control to On for the rule to evaluate as true; that is, for the
/// gating control "switch" to be "On". When you do that, then you can update
/// the routing control states for the target routing controls that you specify
/// in the gating rule.
pub const GatingRule = struct {
    /// The Amazon Resource Name (ARN) of the control panel.
    control_panel_arn: []const u8,

    /// An array of gating routing control Amazon Resource Names (ARNs). For a
    /// simple "on/off" switch, specify the ARN for one routing control. The gating
    /// routing controls are evaluated by the rule configuration that you specify to
    /// determine if the target routing control states can be changed.
    gating_controls: []const []const u8,

    /// The name for the gating rule. You can use any non-white space character in
    /// the name.
    name: []const u8,

    /// The Amazon Web Services account ID of the gating rule owner.
    owner: ?[]const u8,

    /// The criteria that you set for gating routing controls that designate how
    /// many of the routing control states must be ON to allow you to update target
    /// routing control states.
    rule_config: RuleConfig,

    /// The Amazon Resource Name (ARN) of the gating rule.
    safety_rule_arn: []const u8,

    /// The deployment status of a gating rule. Status can be one of the following:
    /// PENDING, DEPLOYED, PENDING_DELETION.
    status: Status,

    /// An array of target routing control Amazon Resource Names (ARNs) for which
    /// the states can only be updated if the rule configuration that you specify
    /// evaluates to true for the gating routing control. As a simple example, if
    /// you have a single gating control, it acts as an overall "on/off" switch for
    /// a set of target routing controls. You can use this to manually override
    /// automated failover, for example.
    target_controls: []const []const u8,

    /// An evaluation period, in milliseconds (ms), during which any request against
    /// the target routing controls will fail. This helps prevent "flapping" of
    /// state. The wait period is 5000 ms by default, but you can choose a custom
    /// value.
    wait_period_ms: i32,

    pub const json_field_names = .{
        .control_panel_arn = "ControlPanelArn",
        .gating_controls = "GatingControls",
        .name = "Name",
        .owner = "Owner",
        .rule_config = "RuleConfig",
        .safety_rule_arn = "SafetyRuleArn",
        .status = "Status",
        .target_controls = "TargetControls",
        .wait_period_ms = "WaitPeriodMs",
    };
};
