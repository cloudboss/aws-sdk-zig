const BatchCreateFirewallRuleResult = @import("batch_create_firewall_rule_result.zig").BatchCreateFirewallRuleResult;

/// Information about the result of creating a DNS Firewall rule in a batch
/// operation.
pub const BatchCreateFirewallRuleOutputItem = struct {
    /// The HTTP response code for the batch operation result.
    code: i32,

    /// The firewall rule that was created in the batch operation.
    firewall_rule: BatchCreateFirewallRuleResult,

    /// A message describing the result of the batch operation, including error
    /// details if applicable.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "code",
        .firewall_rule = "firewallRule",
        .message = "message",
    };
};
