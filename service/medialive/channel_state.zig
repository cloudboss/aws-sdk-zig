/// Placeholder documentation for ChannelState
pub const ChannelState = enum {
    creating,
    create_failed,
    idle,
    starting,
    running,
    recovering,
    stopping,
    deleting,
    deleted,
    updating,
    update_failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .create_failed = "CREATE_FAILED",
        .idle = "IDLE",
        .starting = "STARTING",
        .running = "RUNNING",
        .recovering = "RECOVERING",
        .stopping = "STOPPING",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .updating = "UPDATING",
        .update_failed = "UPDATE_FAILED",
    };
};
