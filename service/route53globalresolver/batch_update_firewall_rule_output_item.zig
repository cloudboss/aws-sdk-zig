const BatchUpdateFirewallRuleResult = @import("batch_update_firewall_rule_result.zig").BatchUpdateFirewallRuleResult;

/// The result of updating a firewall rule in a batch operation.
pub const BatchUpdateFirewallRuleOutputItem = struct {
    /// The response code for the update operation.
    code: i32,

    /// The firewall rule that was updated in the batch operation.
    firewall_rule: BatchUpdateFirewallRuleResult,

    /// The response message for the update operation.
    message: ?[]const u8,

    pub const json_field_names = .{
        .code = "code",
        .firewall_rule = "firewallRule",
        .message = "message",
    };
};
