const PortRange = @import("port_range.zig").PortRange;

/// Describes a security group rule.
pub const AnalysisSecurityGroupRule = struct {
    /// The IPv4 address range, in CIDR notation.
    cidr: ?[]const u8 = null,

    /// The direction. The following are the possible values:
    ///
    /// * egress
    ///
    /// * ingress
    direction: ?[]const u8 = null,

    /// The port range.
    port_range: ?PortRange = null,

    /// The prefix list ID.
    prefix_list_id: ?[]const u8 = null,

    /// The protocol name.
    protocol: ?[]const u8 = null,

    /// The security group ID.
    security_group_id: ?[]const u8 = null,
};
