const AvailabilityZone = @import("availability_zone.zig").AvailabilityZone;
const SubnetOutpost = @import("subnet_outpost.zig").SubnetOutpost;
const NetworkType = @import("network_type.zig").NetworkType;

/// Represents the subnet associated with a cluster. This parameter refers to
/// subnets
/// defined in Amazon Virtual Private Cloud (Amazon VPC) and used with
/// ElastiCache.
pub const Subnet = struct {
    /// The Availability Zone associated with the subnet.
    subnet_availability_zone: ?AvailabilityZone,

    /// The unique identifier for the subnet.
    subnet_identifier: ?[]const u8,

    /// The outpost ARN of the subnet.
    subnet_outpost: ?SubnetOutpost,

    /// Either `ipv4` | `ipv6` | `dual_stack`. IPv6 is
    /// supported for workloads using Valkey 7.2 and above, Redis OSS engine version
    /// 6.2
    /// to 7.1 or Memcached engine version 1.6.6 and above on all instances built on
    /// the [Nitro system](http://aws.amazon.com/ec2/nitro/).
    supported_network_types: ?[]const NetworkType,
};
