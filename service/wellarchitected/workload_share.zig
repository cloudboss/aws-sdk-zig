const PermissionType = @import("permission_type.zig").PermissionType;
const ShareStatus = @import("share_status.zig").ShareStatus;

/// A workload share return object.
pub const WorkloadShare = struct {
    permission_type: ?PermissionType,

    shared_by: ?[]const u8,

    shared_with: ?[]const u8,

    share_id: ?[]const u8,

    status: ?ShareStatus,

    workload_id: ?[]const u8,

    workload_name: ?[]const u8,

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
