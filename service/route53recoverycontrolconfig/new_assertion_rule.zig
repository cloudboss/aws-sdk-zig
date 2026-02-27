const RuleConfig = @import("rule_config.zig").RuleConfig;

/// A new assertion rule for a control panel.
pub const NewAssertionRule = struct {
    /// The routing controls that are part of transactions that are evaluated to
    /// determine if a request to change a routing control state is allowed. For
    /// example, you might include three routing controls, one for each of three
    /// Amazon Web Services Regions.
    asserted_controls: []const []const u8,

    /// The Amazon Resource Name (ARN) for the control panel.
    control_panel_arn: []const u8,

    /// The name of the assertion rule. You can use any non-white space character in
    /// the name.
    name: []const u8,

    /// The criteria that you set for specific assertion controls (routing controls)
    /// that designate how many control states must be ON as the result of a
    /// transaction. For example, if you have three assertion controls, you might
    /// specify ATLEAST 2 for your rule configuration. This means that at least two
    /// assertion controls must be ON, so that at least two Amazon Web Services
    /// Regions have traffic flowing to them.
    rule_config: RuleConfig,

    /// An evaluation period, in milliseconds (ms), during which any request against
    /// the target routing controls will fail. This helps prevent "flapping" of
    /// state. The wait period is 5000 ms by default, but you can choose a custom
    /// value.
    wait_period_ms: i32,

    pub const json_field_names = .{
        .asserted_controls = "AssertedControls",
        .control_panel_arn = "ControlPanelArn",
        .name = "Name",
        .rule_config = "RuleConfig",
        .wait_period_ms = "WaitPeriodMs",
    };
};
