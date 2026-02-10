/// Public hostname type options. For more information, see [EC2 instance
/// hostnames, DNS names, and
/// domains](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-naming.html) in the *Amazon EC2 User Guide*.
pub const PublicIpDnsNameOptions = struct {
    /// The public hostname type. For more information, see [EC2 instance hostnames,
    /// DNS names, and
    /// domains](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-naming.html) in the *Amazon EC2 User Guide*.
    dns_hostname_type: ?[]const u8,

    /// A dual-stack public hostname for a network interface. Requests from within
    /// the VPC resolve to both the private IPv4 address and the IPv6 Global Unicast
    /// Address of the network interface. Requests from the internet resolve to both
    /// the public IPv4 and the IPv6 GUA address of the network interface.
    public_dual_stack_dns_name: ?[]const u8,

    /// An IPv4-enabled public hostname for a network interface. Requests from
    /// within the VPC resolve to the private primary IPv4 address of the network
    /// interface. Requests from the internet resolve to the public IPv4 address of
    /// the network interface.
    public_ipv_4_dns_name: ?[]const u8,

    /// An IPv6-enabled public hostname for a network interface. Requests from
    /// within the VPC or from the internet resolve to the IPv6 GUA of the network
    /// interface.
    public_ipv_6_dns_name: ?[]const u8,
};
