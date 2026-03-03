/// Indicates the slot configuration and global identifier for a slice group.
pub const GlobalNodeGroup = struct {
    /// The name of the global node group
    global_node_group_id: ?[]const u8 = null,

    /// The keyspace for this node group
    slots: ?[]const u8 = null,
};
