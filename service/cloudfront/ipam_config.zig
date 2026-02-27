const IpamCidrConfig = @import("ipam_cidr_config.zig").IpamCidrConfig;

/// The configuration IPAM settings that includes the quantity of CIDR
/// configurations and the list of IPAM CIDR configurations.
pub const IpamConfig = struct {
    /// A list of IPAM CIDR configurations that define the IP address ranges, IPAM
    /// pools, and associated Anycast IP addresses.
    ipam_cidr_configs: []const IpamCidrConfig,

    /// The number of IPAM CIDR configurations in the `IpamCidrConfigs` list.
    quantity: i32,
};
