const ManagedResourceStatus = @import("managed_resource_status.zig").ManagedResourceStatus;

/// The listeners associated with the Express service's Application Load
/// Balancer.
pub const ManagedListener = struct {
    /// The Amazon Resource Name (ARN) of the load balancer listener.
    arn: ?[]const u8 = null,

    /// The status of the load balancer listener.
    status: ManagedResourceStatus,

    /// Informaion about why the load balancer listener is in the current status.
    status_reason: ?[]const u8 = null,

    /// The Unix timestamp for when this listener was most recently updated.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .status = "status",
        .status_reason = "statusReason",
        .updated_at = "updatedAt",
    };
};
