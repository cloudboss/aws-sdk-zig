const ManagedResourceStatus = @import("managed_resource_status.zig").ManagedResourceStatus;

/// The Application Load Balancer associated with the Express service.
pub const ManagedLoadBalancer = struct {
    /// The Amazon Resource Name (ARN) of the load balancer.
    arn: ?[]const u8,

    /// The scheme of the load balancer. By default, the scheme of the load balancer
    /// is
    /// `internet-facing`.
    scheme: []const u8,

    /// The IDs of the security groups associated with the load balancer.
    security_group_ids: ?[]const []const u8,

    /// The status of the load balancer.
    status: ManagedResourceStatus,

    /// Information about why the load balancer is in the current status.
    status_reason: ?[]const u8,

    /// The IDs of the subnets associated with the load balancer.
    subnet_ids: ?[]const []const u8,

    /// The Unix timestamp for when this load balancer was most recently updated.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .scheme = "scheme",
        .security_group_ids = "securityGroupIds",
        .status = "status",
        .status_reason = "statusReason",
        .subnet_ids = "subnetIds",
        .updated_at = "updatedAt",
    };
};
