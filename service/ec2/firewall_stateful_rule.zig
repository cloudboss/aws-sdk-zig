const PortRange = @import("port_range.zig").PortRange;

/// Describes a stateful rule.
pub const FirewallStatefulRule = struct {
    /// The destination ports.
    destination_ports: ?[]const PortRange = null,

    /// The destination IP addresses, in CIDR notation.
    destinations: ?[]const []const u8 = null,

    /// The direction. The possible values are `FORWARD` and `ANY`.
    direction: ?[]const u8 = null,

    /// The protocol.
    protocol: ?[]const u8 = null,

    /// The rule action. The possible values are `pass`, `drop`, and
    /// `alert`.
    rule_action: ?[]const u8 = null,

    /// The ARN of the stateful rule group.
    rule_group_arn: ?[]const u8 = null,

    /// The source ports.
    source_ports: ?[]const PortRange = null,

    /// The source IP addresses, in CIDR notation.
    sources: ?[]const []const u8 = null,
};
