const NodeType = @import("node_type.zig").NodeType;
const NodeOwnerInfo = @import("node_owner_info.zig").NodeOwnerInfo;

/// Details about an individual managed node.
pub const Node = struct {
    /// The UTC timestamp for when the managed node data was last captured.
    capture_time: ?i64,

    /// The ID of the managed node.
    id: ?[]const u8,

    /// Information about the type of node.
    node_type: ?NodeType,

    /// Information about the ownership of the managed node.
    owner: ?NodeOwnerInfo,

    /// The Amazon Web Services Region that a managed node was created in or
    /// assigned to.
    region: ?[]const u8,

    pub const json_field_names = .{
        .capture_time = "CaptureTime",
        .id = "Id",
        .node_type = "NodeType",
        .owner = "Owner",
        .region = "Region",
    };
};
