const RuleConfig = @import("rule_config.zig").RuleConfig;
const Status = @import("status.zig").Status;

/// An assertion rule enforces that, when you change a routing control state,
/// that the criteria that you set in the rule configuration is met. Otherwise,
/// the change to the routing control is not accepted. For example, the criteria
/// might be that at least one routing control state is On after the transaction
/// so that traffic continues to flow to at least one cell for the application.
/// This ensures that you avoid a fail-open scenario.
pub const AssertionRule = struct {
    /// The routing controls that are part of transactions that are evaluated to
    /// determine if a request to change a routing control state is allowed. For
    /// example, you might include three routing controls, one for each of three
    /// Amazon Web Services Regions.
    asserted_controls: []const []const u8,

    /// The Amazon Resource Name (ARN) of the control panel.
    control_panel_arn: []const u8,

    /// Name of the assertion rule. You can use any non-white space character in the
    /// name.
    name: []const u8,

    /// The Amazon Web Services account ID of the assertion rule owner.
    owner: ?[]const u8 = null,

    /// The criteria that you set for specific assertion routing controls
    /// (AssertedControls) that designate how many routing control states must be ON
    /// as the result of a transaction. For example, if you have three assertion
    /// routing controls, you might specify ATLEAST 2 for your rule configuration.
    /// This means that at least two assertion routing control states must be ON, so
    /// that at least two Amazon Web Services Regions have traffic flowing to them.
    rule_config: RuleConfig,

    /// The Amazon Resource Name (ARN) of the assertion rule.
    safety_rule_arn: []const u8,

    /// The deployment status of an assertion rule. Status can be one of the
    /// following: PENDING, DEPLOYED, PENDING_DELETION.
    status: Status,

    /// An evaluation period, in milliseconds (ms), during which any request against
    /// the target routing controls will fail. This helps prevent "flapping" of
    /// state. The wait period is 5000 ms by default, but you can choose a custom
    /// value.
    wait_period_ms: i32,

    pub const json_field_names = .{
        .asserted_controls = "AssertedControls",
        .control_panel_arn = "ControlPanelArn",
        .name = "Name",
        .owner = "Owner",
        .rule_config = "RuleConfig",
        .safety_rule_arn = "SafetyRuleArn",
        .status = "Status",
        .wait_period_ms = "WaitPeriodMs",
    };
};
