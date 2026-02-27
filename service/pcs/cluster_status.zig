pub const ClusterStatus = enum {
    creating,
    active,
    updating,
    deleting,
    create_failed,
    delete_failed,
    update_failed,
    suspending,
    suspended,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .create_failed = "CREATE_FAILED",
        .delete_failed = "DELETE_FAILED",
        .update_failed = "UPDATE_FAILED",
        .suspending = "SUSPENDING",
        .suspended = "SUSPENDED",
    };
};
