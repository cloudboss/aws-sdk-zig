const Group = @import("group.zig").Group;

pub const ListGroupsResponse = struct {
    /// The list of the groups.
    group_list: ?[]const Group = null,

    /// A pagination token that can be used in a subsequent request.
    next_token: ?[]const u8 = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: i32 = 0,

    pub const json_field_names = .{
        .group_list = "GroupList",
        .next_token = "NextToken",
        .request_id = "RequestId",
        .status = "Status",
    };
};
