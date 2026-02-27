const RuleConfig = @import("rule_config.zig").RuleConfig;

/// A new gating rule for a control panel.
pub const NewGatingRule = struct {
    /// The Amazon Resource Name (ARN) of the control panel.
    control_panel_arn: []const u8,

    /// The gating controls for the new gating rule. That is, routing controls that
    /// are evaluated by the rule configuration that you specify.
    gating_controls: []const []const u8,

    /// The name for the new gating rule.
    name: []const u8,

    /// The criteria that you set for specific gating controls (routing controls)
    /// that designate how many control states must be ON to allow you to change
    /// (set or unset) the target control states.
    rule_config: RuleConfig,

    /// Routing controls that can only be set or unset if the specified RuleConfig
    /// evaluates to true for the specified GatingControls. For example, say you
    /// have three gating controls, one for each of three Amazon Web Services
    /// Regions. Now you specify ATLEAST 2 as your RuleConfig. With these settings,
    /// you can only change (set or unset) the routing controls that you have
    /// specified as TargetControls if that rule evaluates to true.
    ///
    /// In other words, your ability to change the routing controls that you have
    /// specified as TargetControls is gated by the rule that you set for the
    /// routing controls in GatingControls.
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
        .rule_config = "RuleConfig",
        .target_controls = "TargetControls",
        .wait_period_ms = "WaitPeriodMs",
    };
};
