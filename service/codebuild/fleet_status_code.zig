pub const FleetStatusCode = enum {
    creating,
    updating,
    rotating,
    pending_deletion,
    deleting,
    create_failed,
    update_rollback_failed,
    active,

    pub const json_field_names = .{
        .creating = "CREATING",
        .updating = "UPDATING",
        .rotating = "ROTATING",
        .pending_deletion = "PENDING_DELETION",
        .deleting = "DELETING",
        .create_failed = "CREATE_FAILED",
        .update_rollback_failed = "UPDATE_ROLLBACK_FAILED",
        .active = "ACTIVE",
    };
};
