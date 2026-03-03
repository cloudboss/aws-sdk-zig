const NodeGroupMemberUpdateStatus = @import("node_group_member_update_status.zig").NodeGroupMemberUpdateStatus;

/// The status of the service update on the node group
pub const NodeGroupUpdateStatus = struct {
    /// The ID of the node group
    node_group_id: ?[]const u8 = null,

    /// The status of the service update on the node group member
    node_group_member_update_status: ?[]const NodeGroupMemberUpdateStatus = null,
};
