const GroupStatusDetail = @import("group_status_detail.zig").GroupStatusDetail;

pub const GetGroupResponse = struct {
    /// The current status of the group.
    status: ?GroupStatusDetail,

    /// The status history of the group.
    status_history: ?[]const GroupStatusDetail,

    pub const json_field_names = .{
        .status = "status",
        .status_history = "statusHistory",
    };
};
