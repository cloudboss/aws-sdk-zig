const AvailabilityZone = @import("availability_zone.zig").AvailabilityZone;
const EnablePrefixForIpv6SourceNatEnum = @import("enable_prefix_for_ipv_6_source_nat_enum.zig").EnablePrefixForIpv6SourceNatEnum;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const IpamPools = @import("ipam_pools.zig").IpamPools;
const LoadBalancerSchemeEnum = @import("load_balancer_scheme_enum.zig").LoadBalancerSchemeEnum;
const LoadBalancerState = @import("load_balancer_state.zig").LoadBalancerState;
const LoadBalancerTypeEnum = @import("load_balancer_type_enum.zig").LoadBalancerTypeEnum;

/// Information about a load balancer.
pub const LoadBalancer = struct {
    /// The subnets for the load balancer.
    availability_zones: ?[]const AvailabilityZone,

    /// The ID of the Amazon Route 53 hosted zone associated with the load balancer.
    canonical_hosted_zone_id: ?[]const u8,

    /// The date and time the load balancer was created.
    created_time: ?i64,

    /// [Application Load Balancers on Outposts] The ID of the customer-owned
    /// address pool.
    customer_owned_ipv_4_pool: ?[]const u8,

    /// The public DNS name of the load balancer.
    dns_name: ?[]const u8,

    /// [Network Load Balancers with UDP listeners] Indicates whether to use an IPv6
    /// prefix
    /// from each subnet for source NAT. The IP address type must be `dualstack`.
    /// The default value is `off`.
    enable_prefix_for_ipv_6_source_nat: ?EnablePrefixForIpv6SourceNatEnum,

    /// Indicates whether to evaluate inbound security group rules for traffic sent
    /// to a
    /// Network Load Balancer through Amazon Web Services PrivateLink.
    enforce_security_group_inbound_rules_on_private_link_traffic: ?[]const u8,

    /// The type of IP addresses used for public or private connections by the
    /// subnets
    /// attached to your load balancer.
    ///
    /// [Application Load Balancers] The possible values are `ipv4` (IPv4
    /// addresses),
    /// `dualstack` (IPv4 and IPv6 addresses), and `dualstack-without-public-ipv4`
    /// (public IPv6 addresses and private IPv4 and IPv6 addresses).
    ///
    /// [Network Load Balancers and Gateway Load Balancers] The possible values are
    /// `ipv4`
    /// (IPv4 addresses) and `dualstack` (IPv4 and IPv6 addresses).
    ip_address_type: ?IpAddressType,

    /// [Application Load Balancers] The IPAM pool in use by the load balancer, if
    /// configured.
    ipam_pools: ?IpamPools,

    /// The Amazon Resource Name (ARN) of the load balancer.
    load_balancer_arn: ?[]const u8,

    /// The name of the load balancer.
    load_balancer_name: ?[]const u8,

    /// The nodes of an Internet-facing load balancer have public IP addresses. The
    /// DNS name of an
    /// Internet-facing load balancer is publicly resolvable to the public IP
    /// addresses of the nodes.
    /// Therefore, Internet-facing load balancers can route requests from clients
    /// over the
    /// internet.
    ///
    /// The nodes of an internal load balancer have only private IP addresses. The
    /// DNS name of an
    /// internal load balancer is publicly resolvable to the private IP addresses of
    /// the nodes.
    /// Therefore, internal load balancers can route requests only from clients with
    /// access to the VPC
    /// for the load balancer.
    scheme: ?LoadBalancerSchemeEnum,

    /// The IDs of the security groups for the load balancer.
    security_groups: ?[]const []const u8,

    /// The state of the load balancer.
    state: ?LoadBalancerState,

    /// The type of load balancer.
    @"type": ?LoadBalancerTypeEnum,

    /// The ID of the VPC for the load balancer.
    vpc_id: ?[]const u8,
};
