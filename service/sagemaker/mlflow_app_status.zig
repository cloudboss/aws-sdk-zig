pub const MlflowAppStatus = enum {
    creating,
    created,
    create_failed,
    updating,
    updated,
    update_failed,
    deleting,
    delete_failed,
    deleted,

    pub const json_field_names = .{
        .creating = "CREATING",
        .created = "CREATED",
        .create_failed = "CREATE_FAILED",
        .updating = "UPDATING",
        .updated = "UPDATED",
        .update_failed = "UPDATE_FAILED",
        .deleting = "DELETING",
        .delete_failed = "DELETE_FAILED",
        .deleted = "DELETED",
    };
};
