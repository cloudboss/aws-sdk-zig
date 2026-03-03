const aws = @import("aws");

const StatusCounts = @import("status_counts.zig").StatusCounts;
const CisTargetStatus = @import("cis_target_status.zig").CisTargetStatus;
const CisTargetStatusReason = @import("cis_target_status_reason.zig").CisTargetStatusReason;

/// The CIS target resource aggregation.
pub const CisTargetResourceAggregation = struct {
    /// The account ID for the CIS target resource.
    account_id: ?[]const u8 = null,

    /// The platform for the CIS target resource.
    platform: ?[]const u8 = null,

    /// The scan ARN for the CIS target resource.
    scan_arn: []const u8,

    /// The target resource status counts.
    status_counts: ?StatusCounts = null,

    /// The ID of the target resource.
    target_resource_id: ?[]const u8 = null,

    /// The tag for the target resource.
    target_resource_tags: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// The status of the target resource.
    target_status: ?CisTargetStatus = null,

    /// The reason for the target resource.
    target_status_reason: ?CisTargetStatusReason = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .platform = "platform",
        .scan_arn = "scanArn",
        .status_counts = "statusCounts",
        .target_resource_id = "targetResourceId",
        .target_resource_tags = "targetResourceTags",
        .target_status = "targetStatus",
        .target_status_reason = "targetStatusReason",
    };
};
