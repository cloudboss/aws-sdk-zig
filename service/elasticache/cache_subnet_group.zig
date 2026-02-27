const Subnet = @import("subnet.zig").Subnet;
const NetworkType = @import("network_type.zig").NetworkType;

/// Represents the output of one of the following operations:
///
/// * `CreateCacheSubnetGroup`
///
/// * `ModifyCacheSubnetGroup`
pub const CacheSubnetGroup = struct {
    /// The ARN (Amazon Resource Name) of the cache subnet group.
    arn: ?[]const u8,

    /// The description of the cache subnet group.
    cache_subnet_group_description: ?[]const u8,

    /// The name of the cache subnet group.
    cache_subnet_group_name: ?[]const u8,

    /// A list of subnets associated with the cache subnet group.
    subnets: ?[]const Subnet,

    /// Either `ipv4` | `ipv6` | `dual_stack`. IPv6 is
    /// supported for workloads using Valkey 7.2 and above, Redis OSS engine version
    /// 6.2
    /// to 7.1 or Memcached engine version 1.6.6 and above on all instances built on
    /// the [Nitro system](http://aws.amazon.com/ec2/nitro/).
    supported_network_types: ?[]const NetworkType,

    /// The Amazon Virtual Private Cloud identifier (VPC ID) of the cache subnet
    /// group.
    vpc_id: ?[]const u8,
};
