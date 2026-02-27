const ManagedResourceStatus = @import("managed_resource_status.zig").ManagedResourceStatus;

/// A security group associated with the Express service.
pub const ManagedSecurityGroup = struct {
    /// The ARN of the security group.
    arn: ?[]const u8,

    /// The status of the security group.
    status: ManagedResourceStatus,

    /// Information about why the security group is in the current status.
    status_reason: ?[]const u8,

    /// The Unix timestamp for when the security group was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .status = "status",
        .status_reason = "statusReason",
        .updated_at = "updatedAt",
    };
};
