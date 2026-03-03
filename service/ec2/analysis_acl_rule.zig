const PortRange = @import("port_range.zig").PortRange;

/// Describes a network access control (ACL) rule.
pub const AnalysisAclRule = struct {
    /// The IPv4 address range, in CIDR notation.
    cidr: ?[]const u8 = null,

    /// Indicates whether the rule is an outbound rule.
    egress: ?bool = null,

    /// The range of ports.
    port_range: ?PortRange = null,

    /// The protocol.
    protocol: ?[]const u8 = null,

    /// Indicates whether to allow or deny traffic that matches the rule.
    rule_action: ?[]const u8 = null,

    /// The rule number.
    rule_number: ?i32 = null,
};
