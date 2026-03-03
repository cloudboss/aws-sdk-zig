/// Describes an IPv6 address associated with a network interface.
pub const NetworkInterfaceIpv6Address = struct {
    /// The IPv6 address.
    ipv_6_address: ?[]const u8 = null,

    /// Determines if an IPv6 address associated with a network interface is the
    /// primary IPv6
    /// address. When you enable an IPv6 GUA address to be a primary IPv6, the first
    /// IPv6 GUA
    /// will be made the primary IPv6 address until the instance is terminated or
    /// the network
    /// interface is detached. For more information, see
    /// [ModifyNetworkInterfaceAttribute](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ModifyNetworkInterfaceAttribute.html).
    is_primary_ipv_6: ?bool = null,

    /// An IPv6-enabled public hostname for a network interface. Requests from
    /// within the VPC or from the internet resolve to the IPv6 GUA of the network
    /// interface. For more information, see [EC2 instance hostnames, DNS names, and
    /// domains](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-naming.html) in the *Amazon EC2 User Guide*.
    public_ipv_6_dns_name: ?[]const u8 = null,
};
