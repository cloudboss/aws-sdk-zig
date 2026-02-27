pub const GraphStatus = enum {
    creating,
    available,
    deleting,
    resetting,
    updating,
    snapshotting,
    failed,
    importing,
    starting,
    stopping,
    stopped,

    pub const json_field_names = .{
        .creating = "CREATING",
        .available = "AVAILABLE",
        .deleting = "DELETING",
        .resetting = "RESETTING",
        .updating = "UPDATING",
        .snapshotting = "SNAPSHOTTING",
        .failed = "FAILED",
        .importing = "IMPORTING",
        .starting = "STARTING",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
    };
};
