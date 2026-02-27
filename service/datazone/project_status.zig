pub const ProjectStatus = enum {
    active,
    deleting,
    delete_failed,
    updating,
    update_failed,
    moving,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .deleting = "DELETING",
        .delete_failed = "DELETE_FAILED",
        .updating = "UPDATING",
        .update_failed = "UPDATE_FAILED",
        .moving = "MOVING",
    };
};
