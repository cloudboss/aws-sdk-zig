const AvailabilityZone = @import("availability_zone.zig").AvailabilityZone;
const AwsElbv2LoadBalancerAttribute = @import("aws_elbv_2_load_balancer_attribute.zig").AwsElbv2LoadBalancerAttribute;
const LoadBalancerState = @import("load_balancer_state.zig").LoadBalancerState;

/// Information about a load balancer.
pub const AwsElbv2LoadBalancerDetails = struct {
    /// The Availability Zones for the load balancer.
    availability_zones: ?[]const AvailabilityZone = null,

    /// The ID of the Amazon Route 53 hosted zone associated with the load balancer.
    canonical_hosted_zone_id: ?[]const u8 = null,

    /// Indicates when the load balancer was created.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    created_time: ?[]const u8 = null,

    /// The public DNS name of the load balancer.
    dns_name: ?[]const u8 = null,

    /// The type of IP addresses used by the subnets for your load balancer. The
    /// possible values
    /// are `ipv4` (for IPv4 addresses) and `dualstack` (for IPv4 and IPv6
    /// addresses).
    ip_address_type: ?[]const u8 = null,

    /// Attributes of the load balancer.
    load_balancer_attributes: ?[]const AwsElbv2LoadBalancerAttribute = null,

    /// The nodes of an Internet-facing load balancer have public IP addresses.
    scheme: ?[]const u8 = null,

    /// The IDs of the security groups for the load balancer.
    security_groups: ?[]const []const u8 = null,

    /// The state of the load balancer.
    state: ?LoadBalancerState = null,

    /// The type of load balancer.
    @"type": ?[]const u8 = null,

    /// The ID of the VPC for the load balancer.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .availability_zones = "AvailabilityZones",
        .canonical_hosted_zone_id = "CanonicalHostedZoneId",
        .created_time = "CreatedTime",
        .dns_name = "DNSName",
        .ip_address_type = "IpAddressType",
        .load_balancer_attributes = "LoadBalancerAttributes",
        .scheme = "Scheme",
        .security_groups = "SecurityGroups",
        .state = "State",
        .@"type" = "Type",
        .vpc_id = "VpcId",
    };
};
