pub const TargetStatus = enum {
    creating,
    updating,
    update_unsuccessful,
    deleting,
    ready,
    failed,
    synchronizing,
    synchronize_unsuccessful,

    pub const json_field_names = .{
        .creating = "CREATING",
        .updating = "UPDATING",
        .update_unsuccessful = "UPDATE_UNSUCCESSFUL",
        .deleting = "DELETING",
        .ready = "READY",
        .failed = "FAILED",
        .synchronizing = "SYNCHRONIZING",
        .synchronize_unsuccessful = "SYNCHRONIZE_UNSUCCESSFUL",
    };
};
