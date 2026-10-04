const UpdateFirewallRuleEntry = @import("update_firewall_rule_entry.zig").UpdateFirewallRuleEntry;

/// An error that occurred while updating a firewall rule in a batch operation.
pub const BatchUpdateFirewallRuleError = struct {
    /// The error code for the failure.
    code: ?[]const u8 = null,

    /// The firewall rule entry that caused the error.
    firewall_rule: ?UpdateFirewallRuleEntry = null,

    /// A message that provides details about the error.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .firewall_rule = "FirewallRule",
        .message = "Message",
    };
};
