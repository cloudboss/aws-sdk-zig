const ManagedResourceStatus = @import("managed_resource_status.zig").ManagedResourceStatus;

/// The CloudWatch metric alarm associated with the Express service's scaling
/// policy.
pub const ManagedMetricAlarm = struct {
    /// The Amazon Resource Name (ARN) of the CloudWatch metric alarm.
    arn: ?[]const u8,

    /// The status of the CloudWatch metric alarm.
    status: ManagedResourceStatus,

    /// Information about why the CloudWatch metric alarm is in the current status.
    status_reason: ?[]const u8,

    /// The Unix timestamp for when the CloudWatch metric alarm was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .status = "status",
        .status_reason = "statusReason",
        .updated_at = "updatedAt",
    };
};
