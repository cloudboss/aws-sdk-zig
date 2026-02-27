const EC2SecurityGroup = @import("ec2_security_group.zig").EC2SecurityGroup;

/// Represents the output of one of the following operations:
///
/// * `AuthorizeCacheSecurityGroupIngress`
///
/// * `CreateCacheSecurityGroup`
///
/// * `RevokeCacheSecurityGroupIngress`
pub const CacheSecurityGroup = struct {
    /// The ARN of the cache security group,
    arn: ?[]const u8,

    /// The name of the cache security group.
    cache_security_group_name: ?[]const u8,

    /// The description of the cache security group.
    description: ?[]const u8,

    /// A list of Amazon EC2 security groups that are associated with this cache
    /// security
    /// group.
    ec2_security_groups: ?[]const EC2SecurityGroup,

    /// The Amazon account ID of the cache security group owner.
    owner_id: ?[]const u8,
};
