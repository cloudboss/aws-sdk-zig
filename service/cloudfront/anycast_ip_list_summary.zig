const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const IpamConfig = @import("ipam_config.zig").IpamConfig;

/// An abbreviated version of the AnycastIpList structure. Omits the allocated
/// static IP addresses (AnycastIpList$AnycastIps).
pub const AnycastIpListSummary = struct {
    /// The Amazon Resource Name (ARN) of the Anycast static IP list.
    arn: []const u8,

    /// The current version (ETag value) of the Anycast static IP list.
    e_tag: ?[]const u8 = null,

    /// The ID of the Anycast static IP list.
    id: []const u8,

    /// The IP address type for the Anycast static IP list.
    ip_address_type: ?IpAddressType = null,

    /// The IPAM configuration for the Anycast static IP list, that contains the
    /// quantity and list of IPAM CIDR configurations.
    ipam_config: ?IpamConfig = null,

    /// The number of IP addresses in the Anycast static IP list.
    ip_count: i32,

    /// The last time the Anycast static IP list was modified.
    last_modified_time: i64,

    /// The name of the Anycast static IP list.
    name: []const u8,

    /// The deployment status of the Anycast static IP list. Valid values: Deployed,
    /// Deploying, or Failed.
    status: []const u8,
};
