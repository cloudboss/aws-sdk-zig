const GroupStatusDetail = @import("group_status_detail.zig").GroupStatusDetail;

pub const GetGroupResponse = struct {
    /// The current status of the group.
    status: ?GroupStatusDetail = null,

    /// The status history of the group.
    status_history: ?[]const GroupStatusDetail = null,

    pub const json_field_names = .{
        .status = "status",
        .status_history = "statusHistory",
    };
};
