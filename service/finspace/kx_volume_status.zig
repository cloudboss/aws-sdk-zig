pub const KxVolumeStatus = enum {
    creating,
    create_failed,
    active,
    updating,
    updated,
    update_failed,
    deleting,
    deleted,
    delete_failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .create_failed = "CREATE_FAILED",
        .active = "ACTIVE",
        .updating = "UPDATING",
        .updated = "UPDATED",
        .update_failed = "UPDATE_FAILED",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .delete_failed = "DELETE_FAILED",
    };
};
