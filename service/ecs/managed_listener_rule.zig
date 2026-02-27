const ManagedResourceStatus = @import("managed_resource_status.zig").ManagedResourceStatus;

/// The listener rule associated with the Express service's Application Load
/// Balancer.
pub const ManagedListenerRule = struct {
    /// The Amazon Resource Name (ARN) of the load balancer listener rule.
    arn: ?[]const u8,

    /// The status of the load balancer listener rule.
    status: ManagedResourceStatus,

    /// Information about why the load balancer listener rule is in the current
    /// status.
    status_reason: ?[]const u8,

    /// The Unix timestamp for when this listener rule was most recently updated.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .status = "status",
        .status_reason = "statusReason",
        .updated_at = "updatedAt",
    };
};
