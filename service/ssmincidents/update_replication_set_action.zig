const AddRegionAction = @import("add_region_action.zig").AddRegionAction;
const DeleteRegionAction = @import("delete_region_action.zig").DeleteRegionAction;

/// Details used when updating the replication set.
pub const UpdateReplicationSetAction = union(enum) {
    /// Details about the Amazon Web Services Region that you're adding to the
    /// replication
    /// set.
    add_region_action: ?AddRegionAction,
    /// Details about the Amazon Web Services Region that you're deleting to the
    /// replication
    /// set.
    delete_region_action: ?DeleteRegionAction,

    pub const json_field_names = .{
        .add_region_action = "addRegionAction",
        .delete_region_action = "deleteRegionAction",
    };
};
