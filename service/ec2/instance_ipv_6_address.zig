/// Describes an IPv6 address.
pub const InstanceIpv6Address = struct {
    /// The IPv6 address.
    ipv_6_address: ?[]const u8 = null,

    /// Determines if an IPv6 address associated with a network interface is the
    /// primary IPv6 address. When you enable an IPv6 GUA address to be a primary
    /// IPv6, the first IPv6 GUA will be made the primary IPv6 address until the
    /// instance is terminated or the network interface is detached.
    /// For more information, see
    /// [RunInstances](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RunInstances.html).
    is_primary_ipv_6: ?bool = null,
};
