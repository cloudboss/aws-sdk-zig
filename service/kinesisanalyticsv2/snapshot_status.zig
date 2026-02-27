pub const SnapshotStatus = enum {
    creating,
    ready,
    deleting,
    failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .ready = "READY",
        .deleting = "DELETING",
        .failed = "FAILED",
    };
};
