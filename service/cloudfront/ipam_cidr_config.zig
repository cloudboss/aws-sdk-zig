const IpamCidrStatus = @import("ipam_cidr_status.zig").IpamCidrStatus;

/// Configuration for an IPAM CIDR that defines a specific IP address range,
/// IPAM pool, and associated Anycast IP address.
pub const IpamCidrConfig = struct {
    /// The specified Anycast IP address allocated from the IPAM pool for this CIDR
    /// configuration.
    anycast_ip: ?[]const u8,

    /// The CIDR that specifies the IP address range for this IPAM configuration.
    cidr: []const u8,

    /// The Amazon Resource Name (ARN) of the IPAM pool that the CIDR block is
    /// assigned to.
    ipam_pool_arn: []const u8,

    /// The current status of the IPAM CIDR configuration.
    status: ?IpamCidrStatus,
};
