/// In a
/// [CreateResolverEndpoint](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_CreateResolverEndpoint.html)
/// request, the IP address that DNS queries originate from (for outbound
/// endpoints) or that you forward DNS queries to (for inbound endpoints).
/// `IpAddressRequest` also includes the ID of the subnet that contains the IP
/// address.
pub const IpAddressRequest = struct {
    /// The IPv4 address that you want to use for DNS queries.
    ip: ?[]const u8 = null,

    /// The IPv6 address that you want to use for DNS queries.
    ipv_6: ?[]const u8 = null,

    /// The ID of the subnet that contains the IP address.
    ///
    /// We recommend using [VPC Resolver on
    /// Outposts](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/outpost-resolver-getting-started.html) to create endpoints on Outposts Racks.
    ///
    /// Outposts subnets with [Local Network Interface
    /// (LNI)](https://docs.aws.amazon.com/outposts/latest/server-userguide/local-network-interface.html) enabled are not compatible with Route 53 Resolver endpoints. If you enable LNI on a subnet that contains Route 53 Resolver endpoint elastic network interfaces (ENIs), those ENIs will stop functioning. For more information, see [Subnet compatibility for Resolver endpoints](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/best-practices-resolver.html#best-practices-resolver-subnet-compatibility) in the *Amazon Route 53 Developer Guide*.
    subnet_id: []const u8,

    pub const json_field_names = .{
        .ip = "Ip",
        .ipv_6 = "Ipv6",
        .subnet_id = "SubnetId",
    };
};
