pub const PipelineStatus = enum {
    creating,
    active,
    updating,
    deleting,
    create_failed,
    update_failed,
    starting,
    start_failed,
    stopping,
    stopped,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .create_failed = "CREATE_FAILED",
        .update_failed = "UPDATE_FAILED",
        .starting = "STARTING",
        .start_failed = "START_FAILED",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
    };
};
