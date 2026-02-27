pub const ClusterState = enum {
    create_in_progress,
    uninitialized,
    initialize_in_progress,
    initialized,
    active,
    update_in_progress,
    modify_in_progress,
    rollback_in_progress,
    delete_in_progress,
    deleted,
    degraded,

    pub const json_field_names = .{
        .create_in_progress = "CREATE_IN_PROGRESS",
        .uninitialized = "UNINITIALIZED",
        .initialize_in_progress = "INITIALIZE_IN_PROGRESS",
        .initialized = "INITIALIZED",
        .active = "ACTIVE",
        .update_in_progress = "UPDATE_IN_PROGRESS",
        .modify_in_progress = "MODIFY_IN_PROGRESS",
        .rollback_in_progress = "ROLLBACK_IN_PROGRESS",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .deleted = "DELETED",
        .degraded = "DEGRADED",
    };
};
