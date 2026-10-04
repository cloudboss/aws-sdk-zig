const DeleteFirewallRuleEntry = @import("delete_firewall_rule_entry.zig").DeleteFirewallRuleEntry;

/// An error that occurred while deleting a firewall rule in a batch operation.
pub const BatchDeleteFirewallRuleError = struct {
    /// The error code for the failure.
    code: ?[]const u8 = null,

    /// The firewall rule entry that caused the error.
    firewall_rule: ?DeleteFirewallRuleEntry = null,

    /// A message that provides details about the error.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .firewall_rule = "FirewallRule",
        .message = "Message",
    };
};
