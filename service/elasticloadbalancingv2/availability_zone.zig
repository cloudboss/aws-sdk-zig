const LoadBalancerAddress = @import("load_balancer_address.zig").LoadBalancerAddress;

/// Information about an Availability Zone.
pub const AvailabilityZone = struct {
    /// [Network Load Balancers] If you need static IP addresses for your load
    /// balancer, you can
    /// specify one Elastic IP address per Availability Zone when you create an
    /// internal-facing load
    /// balancer. For internal load balancers, you can specify a private IP address
    /// from the IPv4
    /// range of the subnet.
    load_balancer_addresses: ?[]const LoadBalancerAddress = null,

    /// [Application Load Balancers on Outposts] The ID of the Outpost.
    outpost_id: ?[]const u8 = null,

    /// [Network Load Balancers with UDP listeners] The IPv6 prefixes to use for
    /// source NAT.
    /// For each subnet, specify an IPv6 prefix (/80 netmask) from the subnet CIDR
    /// block or
    /// `auto_assigned` to use an IPv6 prefix selected at random from the subnet
    /// CIDR
    /// block.
    source_nat_ipv_6_prefixes: ?[]const []const u8 = null,

    /// The ID of the subnet. You can specify one subnet per Availability Zone.
    subnet_id: ?[]const u8 = null,

    /// The name of the Availability Zone.
    zone_name: ?[]const u8 = null,
};
