pub const AnomalyDetectorStatusCode = enum {
    creating,
    active,
    updating,
    deleting,
    creation_failed,
    update_failed,
    deletion_failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .creation_failed = "CREATION_FAILED",
        .update_failed = "UPDATE_FAILED",
        .deletion_failed = "DELETION_FAILED",
    };
};
