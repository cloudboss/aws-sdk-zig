const NodeInfo = @import("node_info.zig").NodeInfo;

pub const ListNodesResponse = struct {
    /// The paginated results marker. When the result of a ListNodes operation is
    /// truncated, the call returns NextToken in the response.
    /// To get another batch of nodes, provide this token in your next request.
    next_token: ?[]const u8 = null,

    /// List containing a NodeInfo object.
    node_info_list: ?[]const NodeInfo = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .node_info_list = "NodeInfoList",
    };
};
