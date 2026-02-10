const StaleIpPermission = @import("stale_ip_permission.zig").StaleIpPermission;

/// Describes a stale security group (a security group that contains stale
/// rules).
pub const StaleSecurityGroup = struct {
    /// The description of the security group.
    description: ?[]const u8,

    /// The ID of the security group.
    group_id: ?[]const u8,

    /// The name of the security group.
    group_name: ?[]const u8,

    /// Information about the stale inbound rules in the security group.
    stale_ip_permissions: ?[]const StaleIpPermission,

    /// Information about the stale outbound rules in the security group.
    stale_ip_permissions_egress: ?[]const StaleIpPermission,

    /// The ID of the VPC for the security group.
    vpc_id: ?[]const u8,
};
