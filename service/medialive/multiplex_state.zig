/// The current state of the multiplex.
pub const MultiplexState = enum {
    creating,
    create_failed,
    idle,
    starting,
    running,
    recovering,
    stopping,
    deleting,
    deleted,

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
    };
};
