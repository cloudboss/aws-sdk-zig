const TargetAddress = @import("target_address.zig").TargetAddress;

/// In an
/// [UpdateResolverRule](https://docs.aws.amazon.com/Route53/latest/APIReference/API_route53resolver_UpdateResolverRule.html)
/// request, information about the changes that you want to make.
pub const ResolverRuleConfig = struct {
    /// The new name for the Resolver rule. The name that you specify appears in the
    /// Resolver dashboard in the Route 53 console.
    ///
    /// The name can be up to 64 characters long and can contain letters (a-z, A-Z),
    /// numbers (0-9), hyphens (-), underscores (_), and spaces. The name cannot
    /// consist of only numbers.
    name: ?[]const u8 = null,

    /// The ID of the new outbound Resolver endpoint that you want to use to route
    /// DNS queries to the IP addresses that you specify in
    /// `TargetIps`.
    resolver_endpoint_id: ?[]const u8 = null,

    /// For DNS queries that originate in your VPC, the new IP addresses that you
    /// want to route outbound DNS queries to.
    target_ips: ?[]const TargetAddress = null,

    pub const json_field_names = .{
        .name = "Name",
        .resolver_endpoint_id = "ResolverEndpointId",
        .target_ips = "TargetIps",
    };
};
