pub const SchedulerResourceStatus = enum {
    creating,
    create_failed,
    create_rollback_failed,
    created,
    updating,
    update_failed,
    update_rollback_failed,
    updated,
    deleting,
    delete_failed,
    delete_rollback_failed,
    deleted,

    pub const json_field_names = .{
        .creating = "CREATING",
        .create_failed = "CREATE_FAILED",
        .create_rollback_failed = "CREATE_ROLLBACK_FAILED",
        .created = "CREATED",
        .updating = "UPDATING",
        .update_failed = "UPDATE_FAILED",
        .update_rollback_failed = "UPDATE_ROLLBACK_FAILED",
        .updated = "UPDATED",
        .deleting = "DELETING",
        .delete_failed = "DELETE_FAILED",
        .delete_rollback_failed = "DELETE_ROLLBACK_FAILED",
        .deleted = "DELETED",
    };
};
