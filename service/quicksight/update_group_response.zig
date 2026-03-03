const Group = @import("group.zig").Group;

pub const UpdateGroupResponse = struct {
    /// The name of the group.
    group: ?Group = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: i32 = 0,

    pub const json_field_names = .{
        .group = "Group",
        .request_id = "RequestId",
        .status = "Status",
    };
};
