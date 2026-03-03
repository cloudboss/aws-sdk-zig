const GroupingType = @import("grouping_type.zig").GroupingType;
const GroupingStatus = @import("grouping_status.zig").GroupingStatus;

/// The information about a grouping or ungrouping resource action.
pub const GroupingStatusesItem = struct {
    /// Describes the resource grouping action with values of
    /// `GROUP` or `UNGROUP`.
    action: ?GroupingType = null,

    /// Specifies the error code that was raised.
    error_code: ?[]const u8 = null,

    /// A message that explains the `ErrorCode`.
    error_message: ?[]const u8 = null,

    /// The Amazon resource name (ARN) of a resource.
    resource_arn: ?[]const u8 = null,

    /// Describes the resource grouping status with values of
    /// `SUCCESS`, `FAILED`, `IN_PROGRESS`,
    /// or `SKIPPED`.
    status: ?GroupingStatus = null,

    /// A timestamp of when the status was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .action = "Action",
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .resource_arn = "ResourceArn",
        .status = "Status",
        .updated_at = "UpdatedAt",
    };
};
