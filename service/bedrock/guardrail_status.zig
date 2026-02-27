pub const GuardrailStatus = enum {
    creating,
    updating,
    versioning,
    ready,
    failed,
    deleting,

    pub const json_field_names = .{
        .creating = "CREATING",
        .updating = "UPDATING",
        .versioning = "VERSIONING",
        .ready = "READY",
        .failed = "FAILED",
        .deleting = "DELETING",
    };
};
