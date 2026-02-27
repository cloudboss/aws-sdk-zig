pub const CapabilityStatus = enum {
    creating,
    create_failed,
    updating,
    deleting,
    delete_failed,
    active,
    degraded,

    pub const json_field_names = .{
        .creating = "CREATING",
        .create_failed = "CREATE_FAILED",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .delete_failed = "DELETE_FAILED",
        .active = "ACTIVE",
        .degraded = "DEGRADED",
    };
};
