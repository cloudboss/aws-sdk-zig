const PermissionType = @import("permission_type.zig").PermissionType;
const ShareStatus = @import("share_status.zig").ShareStatus;

/// A workload share return object.
pub const WorkloadShare = struct {
    permission_type: ?PermissionType = null,

    shared_by: ?[]const u8 = null,

    shared_with: ?[]const u8 = null,

    share_id: ?[]const u8 = null,

    status: ?ShareStatus = null,

    workload_id: ?[]const u8 = null,

    workload_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .permission_type = "PermissionType",
        .shared_by = "SharedBy",
        .shared_with = "SharedWith",
        .share_id = "ShareId",
        .status = "Status",
        .workload_id = "WorkloadId",
        .workload_name = "WorkloadName",
    };
};
