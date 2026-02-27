pub const ScalingStatusType = enum {
    active,
    update_requested,
    updating,
    delete_requested,
    deleting,
    deleted,
    @"error",

    pub const json_field_names = .{
        .active = "ACTIVE",
        .update_requested = "UPDATE_REQUESTED",
        .updating = "UPDATING",
        .delete_requested = "DELETE_REQUESTED",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .@"error" = "ERROR",
    };
};
