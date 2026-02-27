const ManagedResourceStatus = @import("managed_resource_status.zig").ManagedResourceStatus;

/// The Cloudwatch Log Group created by Amazon ECS for an Express service.
pub const ManagedLogGroup = struct {
    /// The Amazon Resource Name (ARN) of the Cloudwatch Log Group associated with
    /// the Express service.
    arn: ?[]const u8,

    /// The name of the Cloudwatch Log Group associated with
    /// the Express service.
    log_group_name: []const u8,

    /// The status of the Cloudwatch LogGroup.
    status: ManagedResourceStatus,

    /// Information about why the Cloudwatch LogGroup is in the current status.
    status_reason: ?[]const u8,

    /// The Unix timestamp for when the Cloudwatch LogGroup was last updated
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .log_group_name = "logGroupName",
        .status = "status",
        .status_reason = "statusReason",
        .updated_at = "updatedAt",
    };
};
