const IpamPoolCidrFailureCode = @import("ipam_pool_cidr_failure_code.zig").IpamPoolCidrFailureCode;

/// Details related to why an IPAM pool CIDR failed to be provisioned.
pub const IpamPoolCidrFailureReason = struct {
    /// An error code related to why an IPAM pool CIDR failed to be provisioned.
    code: ?IpamPoolCidrFailureCode,

    /// A message related to why an IPAM pool CIDR failed to be provisioned.
    message: ?[]const u8,
};
