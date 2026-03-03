const BatchDeleteFirewallRuleResult = @import("batch_delete_firewall_rule_result.zig").BatchDeleteFirewallRuleResult;

/// The result of deleting a firewall rule in a batch operation.
pub const BatchDeleteFirewallRuleOutputItem = struct {
    /// The response code for the delete operation.
    code: i32,

    /// The firewall rule that was deleted in the batch operation.
    firewall_rule: BatchDeleteFirewallRuleResult,

    /// The response message for the delete operation.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "code",
        .firewall_rule = "firewallRule",
        .message = "message",
    };
};
