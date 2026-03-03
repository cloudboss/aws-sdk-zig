const PermissionType = @import("permission_type.zig").PermissionType;
const ShareStatus = @import("share_status.zig").ShareStatus;

/// A workload share summary return object.
pub const WorkloadShareSummary = struct {
    permission_type: ?PermissionType = null,

    shared_with: ?[]const u8 = null,

    share_id: ?[]const u8 = null,

    status: ?ShareStatus = null,

    /// Optional message to compliment the Status field.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .permission_type = "PermissionType",
        .shared_with = "SharedWith",
        .share_id = "ShareId",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};
