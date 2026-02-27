pub const WorkspacesPoolState = enum {
    creating,
    deleting,
    running,
    starting,
    stopped,
    stopping,
    updating,

    pub const json_field_names = .{
        .creating = "CREATING",
        .deleting = "DELETING",
        .running = "RUNNING",
        .starting = "STARTING",
        .stopped = "STOPPED",
        .stopping = "STOPPING",
        .updating = "UPDATING",
    };
};
