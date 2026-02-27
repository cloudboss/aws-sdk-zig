/// The state of a replicator.
pub const ReplicatorState = enum {
    running,
    creating,
    updating,
    deleting,
    failed,

    pub const json_field_names = .{
        .running = "RUNNING",
        .creating = "CREATING",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .failed = "FAILED",
    };
};
