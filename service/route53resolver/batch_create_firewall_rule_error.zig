const CreateFirewallRuleEntry = @import("create_firewall_rule_entry.zig").CreateFirewallRuleEntry;

/// An error that occurred while creating a firewall rule in a batch operation.
pub const BatchCreateFirewallRuleError = struct {
    /// The error code for the failure.
    code: ?[]const u8 = null,

    /// The firewall rule entry that caused the error.
    firewall_rule: ?CreateFirewallRuleEntry = null,

    /// A message that provides details about the error.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .firewall_rule = "FirewallRule",
        .message = "Message",
    };
};
