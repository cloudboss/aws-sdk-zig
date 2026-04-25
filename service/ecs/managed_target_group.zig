const ManagedResourceStatus = @import("managed_resource_status.zig").ManagedResourceStatus;

/// The target group associated with the Express service's Application Load
/// Balancer. For more information about load balancer target groups, see
/// [CreateTargetGroup](https://docs.aws.amazon.com/elasticloadbalancing/latest/APIReference/API_CreateTargetGroup.html) in the *Elastic Load Balancing API Reference*
pub const ManagedTargetGroup = struct {
    /// The Amazon Resource Name (ARN) of the target group.
    arn: ?[]const u8 = null,

    /// The destination for health checks on the targets.
    health_check_path: []const u8,

    /// The port the load balancer uses when performing health checks on targets.
    health_check_port: i32 = 0,

    /// The port on which the targets receive traffic.
    port: i32 = 0,

    /// The status of the target group.
    status: ManagedResourceStatus,

    /// Information about why the target group is in the current status.
    status_reason: ?[]const u8 = null,

    /// The Unix timestamp for when the target group was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .health_check_path = "healthCheckPath",
        .health_check_port = "healthCheckPort",
        .port = "port",
        .status = "status",
        .status_reason = "statusReason",
        .updated_at = "updatedAt",
    };
};
