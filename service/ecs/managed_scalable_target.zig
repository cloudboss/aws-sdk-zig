const ManagedResourceStatus = @import("managed_resource_status.zig").ManagedResourceStatus;

/// Represents a scalable target.
pub const ManagedScalableTarget = struct {
    /// The ARN of the scalable target.
    arn: ?[]const u8,

    /// The maximum value to scale to in response to a scale-out activity.
    max_capacity: i32 = 0,

    /// The minimum value to scale to in response to a scale-in activity.
    min_capacity: i32 = 0,

    /// The status of the scalable target.
    status: ManagedResourceStatus,

    /// Information about why the scalable target is in the current status.
    status_reason: ?[]const u8,

    /// The Unix timestamp for when the target was most recently updated.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .max_capacity = "maxCapacity",
        .min_capacity = "minCapacity",
        .status = "status",
        .status_reason = "statusReason",
        .updated_at = "updatedAt",
    };
};
